extends MeshInstance3D

var time = 10
var radius = 10.0
var speed: float = 10.0

func _process(delta: float) -> void:
	if time <= 0:
		scale = Vector3.ZERO
		time = 10
	else:
		scale += Vector3.ONE * speed * delta
		time -= delta
