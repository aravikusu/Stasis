@tool
extends Node3D


@export_enum("Purple", "Green") var background:
	set(newBG):
		background = newBG

@onready var screen = $SubViewport/PCMainScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		screen.setBG(background)
