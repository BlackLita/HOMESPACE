extends Node3D

var detected_objects = []

var radius: float = 1.0
var max_radius: int = 100
var time: float = 0.0
var speed: float = 5.0
var sphere = SphereShape3D.new()
var is_broken: bool = false

@onready var systems: Dictionary[String, ShipSystem] = {
	"sonar": $"../../Systems/SonarSystem",
}

@onready var control: Control = $detected_objects/SubViewport/Control/VBoxContainer

func _ready() -> void:
	sphere.radius = 1.0

func _process(delta: float) -> void:
	var names = []
	for obj in detected_objects:
		names.append(obj.name)
	control.get_node("detected_obj").text = "Обнаружено:\n" + "\n".join(names)
	time -= delta
	
	if time <= 0:
		time = 10.0
		radius = 1.0
		detected_objects.clear()
		
	if radius < max_radius:
		radius += speed * delta
		
	if radius > 1:
		ping()

func ping():
	var sonar_system = systems["sonar"]
	var space = get_world_3d().direct_space_state
	var query = PhysicsShapeQueryParameters3D.new()
	

	if !sonar_system.can_operate():
		return
	
	query.shape = sphere
	query.transform = global_transform
	sphere.radius = radius
	
	var result = space.intersect_shape(query)

	for hit in result:
		var obj = hit.collider
		if obj in detected_objects:
			continue
		detected_objects.append(obj)
