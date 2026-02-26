class_name MaterialData
extends Resource
## MaterialData - Defines material properties for Bleep

@export var material_name: String = ""
@export var magnetic_susceptibility: float = 0.0
@export var speed_modifier: float = 1.0
@export var health_modifier: float = 1.0
@export var collision_damage_multiplier: float = 1.0
@export var color: Color = Color.WHITE

static func get_materials() -> Dictionary:
	var materials_dir = "res://resources/materials/"
	# Ensure directory exists
	var dir = DirAccess.open(materials_dir)
	if not dir:
		DirAccess.make_dir_recursive_absolute(materials_dir)

	var materials = {}

	var names = ["wood", "aluminum", "steel", "plastic", "ruby"]
	var susceptibility = [0.25, 0.5, 1.0, 0.1, 0.0]
	var speed = [0.75, 1.25, 1.2, 0.9, 1.0]
	var health = [0.8, 1.0, 1.0, 1.2, 1.5]
	var colors = [
		Color(0.55, 0.27, 0.07),
		Color(0.75, 0.75, 0.75),
		Color(0.5, 0.5, 0.5),
		Color(0.2, 0.6, 0.3),
		Color(0.8, 0.05, 0.2)
	]

	for i in range(names.size()):
		var name = names[i]
		var path = materials_dir + name + ".tres"
		if ResourceLoader.exists(path):
			materials[name] = load(path)
		else:
			var mat_script = load("res://scripts/material_data.gd")
			var mat = mat_script.new()
			mat.material_name = name.capitalize()
			mat.magnetic_susceptibility = susceptibility[i]
			mat.speed_modifier = speed[i]
			mat.health_modifier = health[i]
			mat.color = colors[i]
			var err = ResourceSaver.save(mat, path)
			if err != OK:
				push_error("Failed to save material: " + path)
			materials[name] = mat

	return materials
