extends ShipSystem
class_name JumpSystem

@onready var systems: Dictionary[String, ShipSystem] = {
	"reactor": $"../Reactor",
	"engine": $"../Engine",
	"sonar": $"../SonarSystem",
}

func can_jump():
	var reactor = systems["reactor"]
	var engine = systems["engine"]
	var sonar = systems["sonar"]
	
	return !is_broken() and !reactor.is_broken() and !engine.is_broken() and !sonar.is_broken()
