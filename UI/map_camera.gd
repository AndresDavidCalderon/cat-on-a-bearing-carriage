extends Camera2D

@onready var player = get_node("/root/World/Player")

func _ready() -> void:
	get_parent().world_2d=get_tree().root.world_2d

func _process(delta: float) -> void:
	position=player.position
