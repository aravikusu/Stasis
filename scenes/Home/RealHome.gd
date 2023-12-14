extends Node

@onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.GAME_STATE == Enums.GAME_STATE.TITLE_SCREEN:
		player.play_transition_animation("loop", "title_lean")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_title_screen_camera_start_the_game() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.play_oneshot_animation("title_lean_end")
	player.play_transition_animation("loop", "normal")
	TransitionCamera.transition($TitleScreenCamera, player.camera, 3.0)
	await TransitionCamera.finished
	Global.set_game_state(Enums.GAME_STATE.HOME)
