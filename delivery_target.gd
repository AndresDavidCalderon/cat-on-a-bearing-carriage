extends Node2D

func _ready() -> void:
	get_node("/root/World").register_target(self)
