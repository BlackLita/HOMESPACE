extends Node3D

@onready var obj: Dictionary = {
	"status_bar": $"../status_bar"
}
@onready var systems: Dictionary = {
	"ship_manager": $"../../../ShipManager",
	"jump_drive": $"../../../Systems/JumpDrive"
}

func _ready() -> void:
	var status_bar = obj["status_bar"]
	
	if status_bar.material_override == null:
		status_bar.material_override = StandardMaterial3D.new()
	

func _process(delta: float) -> void:
	var jump_drive: JumpSystem = systems["jump_drive"]
	var status_bar = obj["status_bar"]
	
	if jump_drive.can_jump():
		status_bar.material_override.albedo_color = Color.GREEN
	else:
		status_bar.material_override.albedo_color = Color.RED

func interect():
	var ship_manager: ShipManager = systems["ship_manager"]
	
	ship_manager.jump()
