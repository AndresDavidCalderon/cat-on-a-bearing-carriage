extends ColorRect

func _ready() -> void:
	visible=Weather.get_weather_today()==Weather.Weather.RAINY
