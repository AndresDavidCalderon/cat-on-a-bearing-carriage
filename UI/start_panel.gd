extends Panel

@onready var score_provider=get_node("/root/World")

func _ready() -> void:
	show()

func _on_start_pressed() -> void:
	hide()


func _on_world_day_stats_set() -> void:
	$DayTitle.text="Day "+str(GlobalScore.current_day)
	$DayDescription.text="""Deliver %s bottles in
%s seconds""" % [score_provider.packet_target,score_provider.target_time]
