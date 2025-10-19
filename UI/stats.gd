extends Control

@onready var match_provider=get_node("/root/World")
@onready var delivery_manager=match_provider.get_node("DeliveryMode")
@onready var defense_manager=match_provider.get_node("DefendTheMilk")

func _ready() -> void:
	if GlobalScore.current_mode==GlobalScore.gameModes.DELIVERY:
		delivery_manager.packet_delivered.connect(_on_world_packet_delivered)
		match_provider.round_stats_set.connect(_on_world_packet_delivered)
		match_provider.match_state_changed.connect(_on_world_match_state_changed)
	else:
		$HBoxContainer/Items.text="Milk bottles remaining"
		match_provider.round_stats_set.connect(update_bottles)
		defense_manager.bottle_lost.connect(update_bottles)

func _on_world_packet_delivered() -> void:
	$HBoxContainer/Num.text=str(delivery_manager.packet_score)+"/"+str(delivery_manager.packet_target)


func _on_world_match_state_changed(new_state: bool) -> void:
	_on_world_packet_delivered()

func update_bottles():
	$HBoxContainer/Num.text=str(defense_manager.get_remaining_bottles())
