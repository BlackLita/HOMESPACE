extends Node3D
class_name ResourcePickup

@export_enum("metal", "electronics", "fuel") var resource: String
@export_range(0.0, 25.0, 1.0) var amount: float
	
func interact(rm: ResourceManager):
	rm.add_resource(resource, amount)
	queue_free()
