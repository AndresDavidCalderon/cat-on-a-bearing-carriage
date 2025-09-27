extends HBoxContainer

@export var day_ui:PackedScene
@export var weathers_textures:Array[Texture]
@export var icons:Array[Texture]

func _ready() -> void:
	var report = Weather.get_forecast_range(GlobalScore.current_day,GlobalScore.current_day+6)
	var day=GlobalScore.current_day
	for i in report:
		var new_day:Panel=day_ui.instantiate()
		new_day.get_node("TextureRect").texture=weathers_textures[i]
		new_day.get_node("Label").text=str(day)
		new_day.get_node("Icons/Weather").texture=icons[i]
		add_child(new_day)
		if day!=GlobalScore.current_day:
			new_day.remove_theme_stylebox_override("panel")
		day+=1
