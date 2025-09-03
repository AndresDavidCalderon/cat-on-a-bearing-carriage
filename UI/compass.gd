extends Control

@onready var target_provider=get_node("/root/World")
@onready var player=get_node("/root/World/Player") as Node2D

func _process(delta: float) -> void:
	if target_provider.current_target!=null:
		var target=target_provider.current_target.position as Vector2
		rotation= target.angle_to_point(player.position)-player.rotation
		
		
