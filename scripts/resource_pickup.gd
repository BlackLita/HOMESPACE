extends Node3D
class_name ResourcePickup

var resource: Array = ["metal", "electronics", "fuel"]
var amount: float = randf_range(8, 15)
	
func interact(rm: ResourceManager):
	rm.add_resource(resource.pick_random(), amount)
	queue_free()
