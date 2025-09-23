extends Panel

signal ended

@export var slides:Array[Texture]
@export var timeline:DialogicTimeline
var current_slide=0

func start():
	grab_focus()
	get_parent().show()
	show()


func _on_next_pressed() -> void:
	current_slide+=1
	if current_slide>=slides.size():
		grab_focus()
		$Next.hide()
		$Next.pressed.disconnect(_on_next_pressed)
		$Full.pressed.disconnect(_on_full_pressed)
		Dialogic.timeline_ended.connect(ended.emit)
		Dialogic.start(timeline)
	else:
		$Slide.texture=slides[current_slide]


func _on_full_pressed() -> void:
	_on_next_pressed()
