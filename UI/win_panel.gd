extends Panel


func _ready() -> void:
	hide()
	get_node("/root/World").win.connect(_on_world_win)
	if GlobalScore.current_day!=1:
		$NextDay.pressed.connect(get_node("/root/World")._on_next_day_pressed)
	else:
		$NextDay.pressed.connect(get_node("%WhichIntro").start)

func _on_world_win() -> void:
	show()
	$DayBeaten/num.text=str(GlobalScore.current_day)


func _on_intro_ended() -> void:
	get_node("/root/World")._on_next_day_pressed()
