extends Node
class_name ShipManager

@onready var systems: Dictionary[String, ShipSystem] = {
	"reactor": $"../Systems/Reactor",
	"engine": $"../Systems/Engine",
	"sonar": $"../Systems/SonarSystem",
	"jump_drive": $"../Systems/JumpDrive"
}

var broken_time: float = 5.0

func _ready() -> void:
	for system in systems.values():
		system.repaired.connect(_on_system_repair)
		system.broken.connect(func(): print("ВНИМАНИЕ: случилась авария"))

func _process(delta: float) -> void:
	broken_time -= delta
	
	if broken_time <= 0:
		broken_time = randf_range(1.0, 5.0)
		random_accident()

func jump():
	var jump_drive: JumpSystem = systems["jump_drive"]
	
	if !jump_drive.can_jump():
		return
	print(1)
	random_accident()

func random_accident():
	var system = systems.values().pick_random()
	
	system.damage(randf_range(10, 25))

func _on_system_repair():
	print("НАЧАЛАСЬ ПОЧИНКА")
