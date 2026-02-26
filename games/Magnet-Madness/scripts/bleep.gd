extends CharacterBody2D
## Bleep - The robot assistant
## Handles AI navigation, material properties, glitches, and damage

# Preload MaterialData script
const MaterialData = preload("res://scripts/material_data.gd")

@export var move_speed: float = 100.0
@export var goal_position: Vector2 = Vector2.ZERO
@export var frame_material: Resource = null  # MaterialData resource

var health: float = 100.0
var damage_taken: bool = false
var current_glitch: String = ""
var glitch_timer: float = 0.0
var glitch_duration: float = 0.0
var _path: PackedVector2Array = []
var _current_target_idx: int = 1  # Skip start point (0)
var _aborted: bool = false
var _original_speed: float = 100.0

# Visual components
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var glitch_timer_node: Timer = $GlitchTimer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	# NavigationAgent2D configuration (defaults are okay for now)
	# nav_agent.set_path_desired_distance(4.0)
	# nav_agent.set_target_desired_distance(4.0)
	# nav_agent.set_path_update_interval(0.5)
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	# Ensure materials exist and set default if none assigned
	if not frame_material:
		var mats = MaterialData.get_materials()
		if mats.has("wood"):
			frame_material = mats["wood"]
		else:
			push_error("Wood material not available")

func _physics_process(delta):
	if not GameManager:
		return
	if GameManager.current_phase != GameManager.Phase.EXPERIMENT or _aborted:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# Check for glitch
	if current_glitch != "":
		_handle_glitch(delta)
		return

	# Check glitch probability based on magnetic field exposure
	if get_tree().get_current_scene().has_method("get_field_strength_at"):
		var field_strength = get_tree().get_current_scene().get_field_strength_at(global_position)
		if field_strength > 0.5 and randf() < 0.01 * frame_material.magnetic_susceptibility * field_strength:
			_trigger_random_glitch()

	# Navigation logic
	if nav_agent.is_navigation_finished():
		# Reached goal
		velocity = Vector2.ZERO
		move_and_slide()
		GameManager.end_experiment(true)  # success=true
		return

	var next_position: Vector2 = nav_agent.get_next_path_position()
	var direction: Vector2 = (next_position - global_position).normalized()
	var target_velocity: Vector2 = direction * move_speed * frame_material.speed_modifier
	velocity = target_velocity
	move_and_slide()

func _handle_glitch(delta):
	glitch_timer -= delta
	if glitch_timer <= 0:
		_current_glitch_end()
		return

	match current_glitch:
		"inverse_controls":
			velocity = -velocity
		"hyper_speed":
			velocity *= 2.0
		"magnet_lock":
			velocity = Vector2.ZERO
			# Pull toward nearest magnetic object
			_apply_magnet_lock()
		"spin_circles":
			velocity = Vector2.RIGHT.rotated(glitch_timer * 10) * 50.0
		"system_crash":
			velocity = Vector2.ZERO
			if glitch_timer < 2.0:
				sprite.modulate = Color(randf(), 0, 0)

func _apply_magnet_lock():
	var scene = get_tree().get_current_scene()
	if scene.has_method("get_nearest_magnetic_object"):
		var nearest = scene.get_nearest_magnetic_object(global_position)
		if nearest:
			var pull_dir = (nearest.global_position - global_position).normalized()
			velocity = pull_dir * 30.0

func _trigger_random_glitch():
	var glitch_types = [
		"inverse_controls",
		"hyper_speed",
		"magnet_lock",
		"spin_circles",
		"system_crash"
	]
	var chosen = glitch_types[randi() % glitch_types.size()]
	_current_glitch_start(chosen)

func _current_glitch_start(glitch_type: String):
	current_glitch = glitch_type
	glitch_duration = randf_range(2.0, 5.0)
	glitch_timer = glitch_duration
	# Visual feedback
	animation_player.play("glitch_" + glitch_type)
	# Emit event for scientist commentary
	GameManager.phase_changed.emit("glitch_" + glitch_type)

func _current_glitch_end():
	current_glitch = ""
	animation_player.play("reset")
	velocity = Vector2.ZERO

func _on_velocity_computed(safe_velocity: Vector2):
	# For smooth movement if using computed velocity
	pass

func reset_for_experiment():
	_aborted = false
	current_glitch = ""
	glitch_timer = 0.0
	health = 100.0 * frame_material.health_modifier
	damage_taken = false
	sprite.modulate = frame_material.color
	position = Vector2(100, 300)  # Default start, will be overridden by level
	_update_navigation()

func abort():
	_aborted = true
	velocity = Vector2.ZERO
	# Might add damage on abort? No, emergency stop prevents damage

func take_damage(amount: float):
	health -= amount
	damage_taken = true
	if health <= 0:
		# Bleep is "broken", experiment ends
		GameManager.end_experiment(false)  # success=false
	else:
		animation_player.play("damage")

func set_goal(goal: Vector2):
	goal_position = goal
	_update_navigation()

func _update_navigation():
	nav_agent.target_position = goal_position
	_path = nav_agent.get_current_navigation_path()
	_current_target_idx = 1
