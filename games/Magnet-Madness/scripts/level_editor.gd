extends Control
## LevelEditor - UI for designing magnetic obstacle courses

# Preload MaterialData script to use its static method
const MaterialData = preload("res://scripts/material_data.gd")

@onready var object_palette: VBoxContainer = $ObjectPalette
@onready var material_selector: HBoxContainer = $MaterialSelector
@onready var start_button: Button = $StartButton

var _selected_object: PackedScene = null
var _selected_material: Resource = null

func _ready():
	_populate_material_selector()
	# Disconnect any previous connections to avoid duplicates on reload
	if start_button.pressed.is_connected(_on_start_pressed):
		start_button.pressed.disconnect(_on_start_pressed)
	start_button.pressed.connect(_on_start_pressed)

func _populate_material_selector():
	for btn in material_selector.get_children():
		btn.queue_free()
	for mat_data in MaterialData.get_materials():
		var mat = MaterialData.get_materials()[mat_data]
		var btn = Button.new()
		btn.text = mat.material_name
		btn.add_theme_color_override("font_color", mat.color)
		btn.pressed.connect(_on_material_selected.bind(mat))
		material_selector.add_child(btn)

func _on_material_selected(material: Resource):
	_selected_material = material
	print("Selected material: ", material.material_name)

func _on_start_pressed():
	# Configure Bleep material
	if _selected_material:
		GameManager.bleep.frame_material = _selected_material
	GameManager.start_experiment()
