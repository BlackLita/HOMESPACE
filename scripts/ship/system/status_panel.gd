extends Node3D

@onready var mesh = $MeshInstance3D
@onready var viewport = $SubViewport


@export var ship: Node

@onready var reactor_label = $SubViewport/Control/VBoxContainer/ReactorLabel
@onready var engine_label = $SubViewport/Control/VBoxContainer/EngineLabel
@onready var sonar_label = $SubViewport/Control/VBoxContainer/SonarLabel

func _ready():
	var mat := StandardMaterial3D.new()

	mat.albedo_texture = viewport.get_texture()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

	mesh.material_override = mat
	
func _process(_delta):
	var reactor = ship.get_node("Systems/Reactor")
	var engine = ship.get_node("Systems/Engine")
	var sonar = ship.get_node("Systems/SonarSystem")

	reactor_label.text = "REACTOR %.0f%%" % reactor.current_hp + " " + reactor.status_now()
	engine_label.text = "ENGINE %.0f%%" % engine.current_hp + " " + engine.status_now()
	sonar_label.text = "SONAR %.0f%%" % sonar.current_hp + " " + sonar.status_now()
