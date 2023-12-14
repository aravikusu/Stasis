extends Node3D
class_name Rem
signal interact(collider: Object)

@onready var armature := $Armature
@onready var anim_tree := $AnimationTree
@onready var raycast := %RayCast3D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		emit_signal("interact", raycast.get_collider())

func set_anim_tree_walk(val: float) -> void:
	anim_tree.set("parameters/walk/blend_position", val)

func rotate_armature_y(val: float, lerp_val: float) -> void:
	armature.rotation.y = lerp_angle(armature.rotation.y, val, lerp_val)

func set_anim_tree_loop_transition(state: String) -> void:
	anim_tree.set("parameters/loop_transition/transition_request", state)

func set_anim_tree_title_lean_end() -> void:
	anim_tree.set("parameters/title_lean_end/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
