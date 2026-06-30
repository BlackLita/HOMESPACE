extends Control

@export var rm: ResourceManager
@onready var metal: Label = $metal

func _process(delta: float) -> void:
	metal.text = str(rm.get_resource("metal"))
