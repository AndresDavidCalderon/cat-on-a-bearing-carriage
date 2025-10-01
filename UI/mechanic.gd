extends Control

@onready var match_provided=get_node("/root/World")

func _ready() -> void:
	hide()

func start():
	match_provided.set_match_state(match_provided.matchState.PAUSED)
	show()


func _on_close_pressed() -> void:
	hide()
	match_provided.set_match_state(match_provided.matchState.PLAYING)
