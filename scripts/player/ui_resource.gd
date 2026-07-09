extends Control

@export var rm: ResourceManager
@onready var metal: Label = $resources/metal
@onready var elec: Label = $resources/elect
@onready var fuel: Label = $resources/fuel

func _process(delta: float) -> void:
	metal.text = str(rm.get_resource("metal"))
	elec.text = str(rm.get_resource("electronics"))
	fuel.text = str(rm.get_resource("fuel"))
	
