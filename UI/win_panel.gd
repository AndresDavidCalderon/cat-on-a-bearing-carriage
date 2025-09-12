extends Panel

func _ready() -> void:
	hide()
	get_node("/root/World").win.connect(_on_world_win)
	$NextDay.pressed.connect(get_node("/root/World")._on_next_day_pressed)

func _on_world_win() -> void:
	show()
	$DayBeaten/num.text=str(GlobalScore.current_day)
