extends Panel

signal ended

@export var slides:Array[Texture]
@export var timeline:DialogicTimeline
var current_slide=0

func start():
	grab_focus()
	get_parent().show()
	show()
	$Slide.texture=slides[0]


func _on_next_pressed() -> void:
	current_slide+=1
	if current_slide>=slides.size():
		$Next.hide()
		Dialogic.start(timeline)
		Dialogic.timeline_ended.connect(ended.emit)
	else:
		$Slide.texture=slides[current_slide]


func _on_full_pressed() -> void:
	_on_next_pressed()
