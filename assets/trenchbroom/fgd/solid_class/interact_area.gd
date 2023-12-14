extends Area3D
class_name InteractArea
signal interact

@export var properties: Dictionary:
	get: 
		return properties
	set(new_properties):
		if (properties != new_properties):
			properties = new_properties
			update_properties()

var interact_label := ""

func _ready() -> void:
	pass

func update_properties() -> void:
	if 'interact_label' in properties:
		interact_label = properties.interact_label

func activate() -> void:
	print("activated")
	emit_signal("interact")
