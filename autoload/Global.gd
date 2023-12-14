extends Node

const SAVE_DIR := "user://saves/"
const SAVE_NAME := "save.dat"

var save_file := SaveFile.new()
var GAME_STATE: Enums.GAME_STATE = Enums.GAME_STATE.TITLE_SCREEN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	verify_save_directory(SAVE_DIR)
	load_data(SAVE_DIR + SAVE_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handle_inputs()

func handle_inputs() -> void:
	if GAME_STATE == Enums.GAME_STATE.DREAM \
	|| GAME_STATE == Enums.GAME_STATE.HOME:
		if Input.is_action_just_pressed("pause"):
			pass

func set_game_state(state: Enums.GAME_STATE) -> void:
	GAME_STATE = state

func verify_save_directory(path: String) -> void:
	DirAccess.make_dir_absolute(path)

func save_data(path: String) -> void:
	var file := FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, "TrixHasANiceRack")
	if file == null:
		print(FileAccess.get_open_error())
		return
	
	var data := save_file.prepare_for_saving()
	
	var json := JSON.stringify(data, "\t")
	file.store_string(json)
	file.close()

func load_data(path: String) -> void:
	if FileAccess.file_exists(path):
		var file := FileAccess.open_encrypted_with_pass(path, FileAccess.READ, "TrixHasANiceRack")
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		var content := file.get_as_text()
		file.close()
		
		var data: Dictionary = JSON.parse_string(content)
		if data == null:
			printerr("Couldn't read %s as a json_string: (%s)" % [path, content])
			return
		save_file.assemble_from_file(data)
	else:
		printerr("Couldn't open file at " + path)
