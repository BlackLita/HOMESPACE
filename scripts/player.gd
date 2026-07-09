extends CharacterBody3D

var speed = 5.0
var can_move: bool = true
var jump_force = 4.5
var mouse_sens = 0.25
var direction: Vector3 = Vector3.ZERO
@onready var head: Node3D = $head
@onready var raycast = $head/Iteract
@onready var camera_3d: Camera3D = $head/Camera3D
@onready var rm: ResourceManager = $resource_manager

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and can_move:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90.0), deg_to_rad(90.0))

func _physics_process(delta: float) -> void:
	var collider: Object = raycast.get_collider()
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "back")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y) ).normalized()
	
	if direction and can_move:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
		velocity.z = move_toward(velocity.z, 0.0, speed)
	
	_handle_interaction(delta)
	
	if OS.is_debug_build():
		_handle_debug_input()
			
	move_and_slide()

func _handle_interaction(delta: float) -> void:
	var collider = raycast.get_collider()
	var target = collider.get_parent() if collider else null
	
	if target is ShipSystem:
		target.update_label()
		if Input.is_action_pressed("interect"):
			target.try_repair(delta, rm)
	elif collider and collider.has_method("interect"):
		if Input.is_action_just_pressed("interect"):
			collider.interect()
		
func _handle_debug_input() -> void:
	if Input.is_action_just_pressed("one"):
		rm.add_resource("metal", 5)
	if Input.is_action_just_pressed("two"):
		rm.add_resource("electronics", 5)
	if Input.is_action_just_pressed("three"):
		rm.add_resource("fuel", 5)
	
	
