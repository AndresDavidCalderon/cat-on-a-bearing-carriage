extends Control

var slide=0

func _ready() -> void:
	$Slides.get_child(slide).show()

func next_slide():
	slide+=1
	if slide<$Slides.get_child_count():
		$Slides.get_child(slide-1).hide()
		$Slides.get_child(slide).show()
	else:
		get_tree().change_scene_to_file("res://main.tscn")

func _on_next_pressed() -> void:
	next_slide()


func _on_visible_pressed() -> void:
	next_slide()
