extends Control

@onready var match_provider=get_node("/root/World")

func _on_world_packet_delivered() -> void:
	$HBoxContainer/Num.text=str(get_node("/root/World").packet_score)+"/"+str(match_provider.packet_target)
