extends Node2D

@onready var match_provider=get_node("/root/World")
@onready var ui=get_node("/root/World/UI/Which")

var cost=80
func _on_interactable_interacted() -> void:
	ui.start_session()
