extends Node3D
class_name ShipSystem

signal broken
signal repaired

var max_hp: float = 100
var current_hp: float = 100

func damage(amount: float) -> void:
	var was_broken = is_broken()
	
	current_hp = max(current_hp - amount, 0)
	
	if !was_broken and is_broken():
		broken.emit()

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

func is_broken() -> bool:
	return current_hp <= 0
