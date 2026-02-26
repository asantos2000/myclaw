extends Node
## GameManager - Autoload singleton
## Manages game state, phases, and core systems

# Preload class scripts to register global classes at compile time
const _MaterialDataScript = preload("res://scripts/material_data.gd")
const _MagneticObjectScript = preload("res://scripts/magnetic_object.gd")

signal experiment_started
signal experiment_ended(success: bool, damage_taken: bool)
signal phase_changed(new_phase: String)

enum Phase { DESIGN, EXPERIMENT, TRANSITION }

var current_phase: Phase = Phase.DESIGN
var experiment_time: float = 30.0
var time_remaining: float = 30.0
var bleep: Node2D = null
var current_level: Node2D = null
var emergency_stop_available: bool = true
var _experiment_active: bool = false

func _ready():
	print("Magnet Madness: GameManager initialized")

func start_experiment():
	if current_phase != Phase.DESIGN:
		return
	if not bleep:
		push_error("No Bleep assigned")
		return

	current_phase = Phase.EXPERIMENT
	_emit_phase_changed()
	experiment_started.emit()
	_experiment_active = true
	emergency_stop_available = true
	time_remaining = experiment_time
	bleep.reset_for_experiment()
	# Enable Bleep AI
	bleep.set_process(true)
	bleep.set_physics_process(true)

func emergency_stop():
	if not _experiment_active or not emergency_stop_available:
		return
	emergency_stop_available = false
	bleep.abort()
	end_experiment(false, true)  # success=false, aborted=true

func end_experiment(success: bool, aborted: bool = false):
	_experiment_active = false
	bleep.set_process(false)
	bleep.set_physics_process(false)
	experiment_ended.emit(success, bleep.damage_taken)
	current_phase = Phase.TRANSITION
	_emit_phase_changed()

	# After brief pause, return to design
	get_tree().create_timer(2.0).timeout.connect(_on_transition_timeout)

func _on_transition_timeout():
	current_phase = Phase.DESIGN
	_emit_phase_changed()

func _emit_phase_changed():
	var phase_name = Phase.keys()[current_phase]
	phase_changed.emit(phase_name)

# Called during design phase to set current level
func set_level(level: Node2D):
	current_level = level

# Called during design phase to assign Bleep
func set_bleep(robot: Node2D):
	bleep = robot

func _process(delta):
	if current_phase == Phase.EXPERIMENT and _experiment_active:
		time_remaining -= delta
		if time_remaining <= 0:
			end_experiment(true)  # success=true

func is_experiment_active() -> bool:
	return _experiment_active

func reset_emergency_stop():
	emergency_stop_available = true
