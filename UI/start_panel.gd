extends Panel

@onready var score_provider=get_node("/root/World")

func _ready() -> void:
	score_provider.day_stats_set.connect(_on_world_day_stats_set)
	show()

func _on_start_pressed() -> void:
	get_node("/root/World")._on_start_pressed()
	hide()


func _on_world_day_stats_set() -> void:
	$DayTitle.text="Day "+str(GlobalScore.current_day)
	$DayDescription.text="""%s bottles in
%s seconds""" % [score_provider.packet_target,score_provider.target_time]
