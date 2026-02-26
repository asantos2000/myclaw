extends Node2D
## Main Level Scene
## Contains course objects, Bleep, goal, and manages magnetic field calculations

# Preload class scripts to ensure they are registered before use
const MaterialData = preload("res://scripts/material_data.gd")
const MagneticObject = preload("res://scripts/magnetic_object.gd")

@onready var bleep: CharacterBody2D = $Bleep
@onready var goal: Area2D = $Goal
@onready var level_editor: Control = $LevelEditor
@onready var experiment_ui: Control = $ExperimentUI
@onready var magnetic_objects: Node = $MagneticObjects

var _magnetic_field_map: Dictionary = {}  # position -> strength

func _ready():
	# Initialize materials (lazy creation via MaterialData.get_materials())
	MaterialData.get_materials()
	# Setup signals
	GameManager.set_bleep(bleep)
	GameManager.set_level(self)
	GameManager.phase_changed.connect(_on_phase_changed)
	bleep.set_goal(goal.global_position)
	_on_phase_changed("DESIGN")
	# Build field map for quick lookup
	_build_magnetic_field_map()

func _build_magnetic_field_map():
	"""Precompute magnetic field strength at grid positions"""
	_magnetic_field_map.clear()
	for obj in magnetic_objects.get_children():
		if obj is MagneticObject:
			# Simple: field strength falls off with distance
			var cell_size = 20.0
			var bounds = obj.field_radius
			for x in range(-int(bounds/cell_size), int(bounds/cell_size)+1):
				for y in range(-int(bounds/cell_size), int(bounds/cell_size)+1):
					var pos = obj.global_position + Vector2(x*cell_size, y*cell_size)
					var dist = pos.distance_to(obj.global_position)
					if dist <= bounds:
						var existing = _magnetic_field_map.get(pos, 0.0)
						var contribution = obj.magnetic_strength * (1.0 - dist/bounds)
						_magnetic_field_map[pos] = existing + contribution

func get_field_strength_at(position: Vector2) -> float:
	"""Return total magnetic field strength at given position"""
	# Snap to grid for lookup
	var cell_size = 20.0
	var snapped = Vector2(
		round(position.x / cell_size) * cell_size,
		round(position.y / cell_size) * cell_size
	)
	return _magnetic_field_map.get(snapped, 0.0)

func get_magnetic_forces_at(position: Vector2, obj: Node2D) -> Array[Vector2]:
	"""Calculate forces from all magnetic objects on given object"""
	var forces: Array[Vector2] = []
	for m in magnetic_objects.get_children():
		if m is MagneticObject:
			var force = m.as_force_on(obj)
			if force != Vector2.ZERO:
				forces.append(force)
	return forces

func get_nearest_magnetic_object(position: Vector2) -> Node2D:
	var nearest: Node2D = null
	var nearest_dist: float = INF
	for m in magnetic_objects.get_children():
		if m is MagneticObject:
			var dist = position.distance_to(m.global_position)
			if dist < nearest_dist:
				nearest_dist = dist
				nearest = m
	return nearest

func _on_phase_changed(phase_name: String):
	match phase_name:
		"DESIGN":
			level_editor.visible = true
			experiment_ui.visible = false
			bleep.set_process(false)
			bleep.set_physics_process(false)
		"EXPERIMENT":
			level_editor.visible = false
			experiment_ui.visible = true
			_update_experiment_ui()
		"TRANSITION":
			experiment_ui.visible = true
			_update_experiment_ui()

func _update_experiment_ui():
	experiment_ui.update_timer(GameManager.time_remaining)
	experiment_ui.update_bleed_state(bleep.health, bleep.current_glitch)
