extends Node3D
class_name ResourcePickup

@export var resource: String
@export var amount: float
	
func interact(rm: ResourceManager):
	rm.add_resource(resource, amount)
	queue_free()
