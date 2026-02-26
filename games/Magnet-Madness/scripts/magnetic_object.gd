class_name MagneticObject
extends StaticBody2D
## MagneticObject - A magnetic field source or affected object
## Can be a magnet, metal object, or obstacle

@export var magnetic_strength: float = 10.0  # Gauss equivalent
@export var polarity: int = 1  # 1 = attract, -1 = repel, 0 = both (alternating)
@export var is_movable: bool = false
@export var weight: float = 1.0
@export var field_radius: float = 200.0

var _base_position: Vector2 = Vector2.ZERO
var _original_velocity: Vector2 = Vector2.ZERO

func _ready():
	_base_position = global_position
	set_process(is_movable)

func _process(delta):
	if is_movable:
		# Apply forces from other magnets
		_apply_magnetic_forces(delta)

func _apply_magnetic_forces(delta: float):
	var scene = get_tree().get_current_scene()
	if not scene.has_method("get_magnetic_forces_at"):
		return
	var forces = scene.get_magnetic_forces_at(global_position, self)
	var total_force = Vector2.ZERO
	for force in forces:
		total_force += force
	# F = ma, a = F/m * delta
	var acceleration = total_force / weight
	_original_velocity += acceleration * delta
	# Apply damping
	_original_velocity *= 0.95
	position += _original_velocity

func get_field_strength() -> float:
	return magnetic_strength

func get_polarity() -> int:
	return polarity

func as_force_on(other: Node2D) -> Vector2:
	"""Calculate magnetic force exerted on another magnetic object"""
	var direction = (other.global_position - global_position).normalized()
	var distance = global_position.distance_to(other.global_position)
	if distance > field_radius:
		return Vector2.ZERO
	var force_magnitude = (magnetic_strength * other.magnetic_strength) / (distance * distance)
	var polarity_factor = 1.0
	if polarity != 0 and other.polarity != 0:
		polarity_factor = polarity * other.polarity  # 1=attract, -1=repel
	return direction * force_magnitude * polarity_factor
