extends Panel


func _ready() -> void:
	hide()
	get_node("/root/World").win.connect(_on_world_win)
	if GlobalScore.current_day==1 and (GlobalScore.current_mode==GlobalScore.gameModes.DEFEND or not GlobalScore.defend_enabled):
		$NextDay.pressed.connect(on_day_1_next)
	else:
		$NextDay.pressed.connect(get_node("/root/World")._on_next_day_pressed)

func on_day_1_next():
	hide()
	get_node("%WhichIntro").start()

func _on_world_win() -> void:
	show()
	$DayBeaten/num.text=str(GlobalScore.current_day)


func _on_intro_ended() -> void:
	get_node("/root/World")._on_next_day_pressed()
