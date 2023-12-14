extends StaticBody3D
class_name Door

@export var properties: Dictionary:
	get: 
		return properties
	set(new_properties):
		if (properties != new_properties):
			properties = new_properties
			update_properties()

@onready var hinge := Node3D.new()

var door_hinge := "left"
var open_direction := "up"
var back := false

func update_properties() -> void:
	if 'door_hinge' in properties:
		door_hinge = properties.door_hinge
	
	if 'open_direction' in properties:
		open_direction = properties.open_direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		swing()

# Making it possible to get the swinging motion we want.
func setup() -> void:
	var g_pos: Vector3 = global_position
	# First we add the door hinge to the scene
	get_tree().root.add_child.call_deferred(hinge)
	hinge.name = "DoorHinge"
	
	# Then we reparent the door itself to the door hinge
	reparent.call_deferred(hinge)
	
	# We now need to re-position door itself based on which corner the
	# properties specify
	var mesh: MeshInstance3D = get_child(0) # Child 0 in a Qodot entity is always the mesh
	var face_pos: Vector3 = mesh.mesh.get_faces()[0]
	
	var axis: float = face_pos.x if door_hinge == "left" else -face_pos.x
	var final_pos := Vector3(axis, 0, 0)
	set_deferred("position", final_pos)
	
	# And lastly we re-adjust the position of the door hinge it self so
	# that it lines up with the geometry
	var new_hinge_pos: Vector3 = g_pos
	new_hinge_pos.x += -axis # The inverse of how we moved the door itself
	hinge.set_deferred("global_position", new_hinge_pos)

func swing() -> void:
	var final_val: float = 1.75 if open_direction == "up" else -1.75
	var tween: Tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)
	if back:
		tween.tween_property(hinge, "rotation", Vector3(0, 0, 0), 2)
	else:
		tween.tween_property(hinge, "rotation", Vector3(0, final_val, 0), 2)
	
	back = !back
