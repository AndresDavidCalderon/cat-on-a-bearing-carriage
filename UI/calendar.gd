extends HBoxContainer

@export var day_ui:PackedScene

func _ready() -> void:
	var report = Weather.get_forecast_range(GlobalScore.current_day,GlobalScore.current_day+6)
	for i in report:
		pass
