extends Control

@export var rm: ResourceManager

var labels: Dictionary[String, Label] = {
	"metal": $resources/metal,
	"electronics": $resources/elect,
	"fuel": $resources/fuel,
}

func _ready() -> void:
	rm.change_resource.connect(_on_resource_change)

func _init_label():
	for resource in labels:
		update_label(resource, rm.get_resource(resource))

func _on_resource_change(resource: String, amount: float, delta: float):
	update_label(resource, amount)
	if delta > 0:
		_flash_label(labels[resource], Color.GREEN)
	if delta < 0:
		_flash_label(labels[resource], Color.RED)

func update_label(resource: String, amount: float):
	if labels.has(resource):
		labels[resource].text = "%s: %.0f" % [resource.capitalize(), amount]

func _flash_label(label: Label, color: Color) -> void:
	label.modulate = color
	var tween: Tween = create_tween()
	tween.tween_property(label, "modulate", Color.WHITE, 0.3)
