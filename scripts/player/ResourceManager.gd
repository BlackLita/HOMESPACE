extends Node
class_name ResourceManager

var resources: Dictionary[String, float] = {
	"metal": 0.0,
	"electronics": 0.0,
	"fuel": 0.0,
}

func add_resource(resource: String, amount: float) -> void: resources[resource] += amount
func remove_resource(resource: String, amount: float) -> void:
	if !has_resource(resource, amount):
		return
	resources[resource] -= amount
func has_resource(resource: String, amount: float) -> bool: return get_resource(resource) >= amount
func get_resource(resource: String) -> float: return resources.get(resource, 0)
