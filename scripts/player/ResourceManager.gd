extends Node
class_name ResourceManager

signal change_resource(type: String, new_amount: float, delta: float)
signal resources_added(type: String, amount: float)
signal resources_removed(type: String, amount: float)
signal insufficient_resources(type: String, amount: float, available: float)

var resources: Dictionary[String, float] = {
	"metal": 0.0,
	"electronics": 0.0,
	"fuel": 0.0,
}

var capacity: Dictionary[String, float] = {
	"metal": 100.0,
	"electronics": 100.0,
	"fuel": 100.0,
}

func add_resource(resource: String, amount: float) -> void:
	if amount <= 0:
		return
	if not resources.has(resource):
		return
	var old_value: float = resources[resource]
	var max_value: float = capacity.get(resource, 100.0)
	var new_value: float = min(old_value + amount, max_value)
	var delta: float = new_value - old_value
	resources[resource] = new_value
	if delta > 0:
		change_resource.emit(resource, new_value, delta)
		resources_added.emit(resource, new_value)

func remove_resource(resource: String, amount: float) -> bool:
	if amount <= 0:
		return false
	if not has_resource(resource, amount):
		insufficient_resources.emit(resource, amount, get_resource(resource))
		return false
	resources[resource] -= amount
	change_resource.emit(resource, resources[resource], -amount)
	resources_removed.emit(resource, amount)
	return true
	

func has_resource(resource: String, amount: float) -> bool:
	return get_resource(resource) >= amount

func get_resource(resource: String) -> float:
	return resources.get(resource, 0)

func can_afford(cost: Dictionary) -> bool:
	for resource in cost:
		if !has_resource(resource, cost[resource]):
			return false
	return true

func spend(cost: Dictionary) -> bool:
	if !can_afford(cost):
		for resource in cost:
			if !has_resource(resource, cost[resource]):
				insufficient_resources.emit(resource, cost[resource], get_resource(resource))
		return false
	for resource in cost:
		remove_resource(resource, cost[resource])
	return true
