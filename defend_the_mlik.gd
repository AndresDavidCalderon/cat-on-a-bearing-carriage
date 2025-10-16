extends Node

@onready var player=get_node("/root/World/Player")

func _ready() -> void:
	if is_mode():
		player.global_position=$NightSpawnLocation.global_position

func is_mode():
	return GlobalScore.current_mode==GlobalScore.gameModes.DEFEND
