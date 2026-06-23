extends CharacterBody3D

var speed = 5.0
var can_move: bool = true
var jump_force = 4.5
var mouse_sens = 0.25
var direction = Vector3.ZERO
@onready var head: Node3D = $head
@onready var raycast = $head/Iteract
@onready var camera_3d: Camera3D = $head/Camera3D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and can_move:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	var input_dir = Input.get_vector("left", "right", "forward", "back")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and can_move:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	var collider = raycast.get_collider()
	
	if collider and collider.get_parent() is ShipSystem:
		var system = collider.get_parent()
		var label = system.get_node("Label3D")
		if system.current_hp < system.max_hp:
			label.visible = true
			label.text = "[E]\nRepair: %s\n%.0f%%" % [system.name, system.current_hp / system.max_hp * 100]
			if Input.is_action_pressed("interact"):
				system.repair(5*delta)
		else:
			label.visible = false

	if Input.is_action_just_pressed("interact"):
		if collider and collider.has_method("interect"):
			collider.interect()
			
	move_and_slide()
	
	
