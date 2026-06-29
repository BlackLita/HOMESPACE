extends Node3D
class_name ShipSystem

signal broken # Emitted when the system becomes completely inoperable.
signal repaired # Emitted when the system is restored from a broken state.

var max_hp: float = 100
var current_hp: float = 100

# Applies damage to the system.
# Emits the `broken` signal if the system becomes inoperable.
func damage(amount: float) -> void:
	var was_broken = is_broken()
	
	current_hp = max(current_hp - amount, 0)
	
	if !was_broken and is_broken():
		broken.emit()

# Repairs the system.
# Emits the `repaired` signal if the system is restored.
func repair(amount: float) -> void:
	var was_broken = is_broken()
	var is_repair = current_hp < max_hp
	
	if is_repair:
		current_hp = min(current_hp + amount, max_hp)
	
	if was_broken and !is_broken():
		repaired.emit()

func status_now() -> String:
	if current_hp >= max_hp:
		return "ONLINE"
	
	if current_hp < max_hp and current_hp > 0:
		return "DAMAGE"
	
	if current_hp <= 0:
		return "ERROR"
	
	return "OFLINE"

# Returns true if the system is completely broken.
func is_broken() -> bool:
	return current_hp <= 0
