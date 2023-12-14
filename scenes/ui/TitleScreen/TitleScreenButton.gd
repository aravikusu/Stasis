@tool
extends MarginContainer

signal clicked

@onready var text_label := %Text

@onready var active_material: LabelSettings =  preload("res://assets/materials/labelsettings/titlebtn_active.tres")
@onready var inactive_material: LabelSettings = preload("res://assets/materials/labelsettings/titlebtn_inactive.tres")
@onready var neutral_material: LabelSettings = preload("res://assets/materials/labelsettings/titlebtn_neutral.tres")

var current_material: LabelSettings

var highlighted := false
@export var inactive := false
@export var text := "Button text"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Duplicating the LabelSettings to make sure that they are unique.
	active_material = active_material.duplicate()
	inactive_material = inactive_material.duplicate()
	neutral_material = neutral_material.duplicate()
	
	text_label.text = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var new_settings: LabelSettings = null
	
	if highlighted:
		new_settings = active_material
	
	if inactive:
		new_settings = inactive_material
	
	if new_settings == null:
		new_settings = neutral_material
	
	if current_material != new_settings:
		current_material = new_settings
		text_label.label_settings = current_material


func _on_label_mouse_entered() -> void:
	highlighted = true


func _on_label_mouse_exited() -> void:
	highlighted = false


func _on_text_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("clicked")
