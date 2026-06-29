extends ShipSystem
class_name EngineSystem

@onready var systems: Dictionary[String, ShipSystem] = {
	"reactor": $"../Reactor"
}

func can_thrust() -> bool:
	var reactor = systems["reactor"]
	
	return !reactor.is_broken() and !is_broken()