extends Panel

@onready var round_manger=get_node("/root/World")
@onready var score_provider=get_node("/root/World/DeliveryMode")

func _ready() -> void:
	round_manger.round_stats_set.connect(_on_world_day_stats_set)
	hide()

func _on_start_pressed() -> void:
	get_node("/root/World")._on_start_pressed()
	hide()


func _on_world_day_stats_set() -> void:
	if GlobalScore.current_mode==GlobalScore.gameModes.DELIVERY:
		$DayTitle.text="Day "+str(GlobalScore.current_day)
		$DayDescription.text="""%s bottles in
		%s seconds""" % [score_provider.packet_target,score_provider.target_time]
	else:
		$DayTitle.text="Night "+str(GlobalScore.current_day)
		$DayDescription.hide()
		$Start.text="Start defense"
	show()
