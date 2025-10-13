extends Control



func set_visible_scene(scene_name):
	for i in get_children():
		i.hide()
	get_node(scene_name).show()

func _ready() -> void:
	set_visible_scene("Default")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://intro/intro.tscn")
