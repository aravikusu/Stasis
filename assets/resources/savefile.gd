extends Resource
class_name SaveFile

@export var file_name: String
@export var effects: Array[Effect]
@export var home_weather: Enums.HOME_WEATHER
@export var home_time: Enums.HOME_TIME
@export var diary_entries: Array[String]

func _init() -> void:
	initialize()

func initialize() -> void:
	file_name = "Rem"
	effects = []
	var fx := Effect.new()
	fx.description = "yes"
	fx.effect_name = "name"
	effects.append(fx)
	home_weather = Enums.HOME_WEATHER.SUNNY
	home_time = Enums.HOME_TIME.EVENING
	diary_entries = []

func prepare_for_saving() -> Dictionary:
	var fx: Array[Dictionary]
	for effect in effects:
		fx.append({
			"effect_name": effect.effect_name,
			"description": effect.description
		})
		
	return {
		"file_name": file_name,
		"effects": fx,
		"home_weather": home_weather,
		"home_time": home_time,
		"diary_entries": JSON.stringify(diary_entries)
	}

func assemble_from_file(content: Dictionary) -> void:
	file_name = content.file_name
	home_weather = content.home_weather
	home_time = content.home_time
	
	var new_effects: Array[Effect]
	for effect: Dictionary in content.effects:
		var fx := Effect.new()
		fx.effect_name = effect.effect_name
		fx.description = effect.description
		new_effects.append(fx)
	effects = new_effects
