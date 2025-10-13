extends Panel

@onready var scene_manager=get_parent().get_node("Scenes")

func _on_play_mouse_entered() -> void:
	scene_manager.set_visible_scene("Play")


func _on_options_mouse_entered() -> void:
	scene_manager.set_visible_scene("Settings")
