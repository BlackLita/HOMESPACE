extends Node3D

@onready var obj: Dictionary = {
	"mesh": $MeshInstance3D,
	"viewport": $SubViewport
}

@export var ship: Node

func _ready():
	var mat = StandardMaterial3D.new()
	var mesh = obj["mesh"]
	var viewport = obj["viewport"]

	mat.albedo_texture = viewport.get_texture()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

	mesh.material_override = mat
