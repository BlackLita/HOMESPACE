extends Node3D
class_name ShipSystem

signal broken # Emitted when the system becomes completely inoperable.
signal repaired # Emitted when the system is restored from a broken state.

var max_hp: float = 100.0
var current_hp: float = 100.0

@export var label: Label3D

# Applies damage to the system.
# Emits the `broken` signal if the system becomes inoperable.
func damage(amount: float) -> void:
	var was_broken: bool = is_broken()
	
	current_hp = max(current_hp - amount, 0)
	
	if !was_broken and is_broken():
		broken.emit()

# Repairs the system.
# Emits the `repaired` signal if the system is restored.
func repair(amount: float) -> void:
	var was_broken: bool = is_broken()
	var is_repair: bool = current_hp < max_hp
	
	if is_repair:
		current_hp = min(current_hp + amount, max_hp)
	
	if was_broken and !is_broken():
		repaired.emit()

func status_now() -> String:
	if current_hp >= max_hp:
		return "ONLINE"
	if  current_hp > 0.0:
		return "DAMAGE"
	return "ERROR"

# Returns true if the system is completely broken.
func is_broken() -> bool:
	return current_hp <= 0

func needs_repair() -> bool:
	return current_hp < max_hp

func get_interact_prompt() -> String:
	return "[E]\nRepair: %s\n%.0f%%" % [name, current_hp / max_hp * 100]

func try_repair(delta: float, rm: ResourceManager) -> void:
	if needs_repair():
		if !rm.has_resource("metal", 5.0):
			return
		repair(5.0*delta)
		rm.remove_resource("metal", 5.0 * delta)

func update_label():
	label.visible = needs_repair()
	if needs_repair():
		label.text = get_interact_prompt()
		
	
	