extends ShipSystem
class_name SonarSystem

@onready var systems: Dictionary[String, ShipSystem] = {
	"reactor": $"../Reactor"
}

func can_operate() -> bool:
	var reactor = systems["reactor"]
	
	return !is_broken() and !reactor.is_broken()
