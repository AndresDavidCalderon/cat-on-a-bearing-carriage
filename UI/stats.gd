extends Control


func _on_world_packet_delivered() -> void:
	$Num.text=str(get_node("/root/World").packet_score)
