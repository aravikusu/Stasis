extends Camera3D
signal start_the_game

@onready var animation_player := $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_new_game_clicked() -> void:
	close_title_screen()

func close_title_screen() -> void:
	animation_player.play("fade")
	emit_signal("start_the_game")


func _on_load_game_clicked() -> void:
	pass # Replace with function body.


func _on_settings_clicked() -> void:
	pass # Replace with function body.


func _on_quit_game_clicked() -> void:
	get_tree().quit()
