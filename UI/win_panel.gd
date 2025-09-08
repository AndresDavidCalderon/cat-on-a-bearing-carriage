extends Panel

func _ready() -> void:
	hide()

func _on_world_win() -> void:
	show()
	$DayBeaten/num.text=str(GlobalScore.current_day)
