extends Node2D

@export var presentation_timeline:DialogicTimeline

func _ready() -> void:
	if GlobalScore.current_day<=GlobalScore.mechanic_day:
		hide()

func _on_mechanic_delivered() -> void:
	if GlobalScore.current_day==GlobalScore.mechanic_day:
		Dialogic.timeline_ended.connect(presentation_ended)
		Dialogic.start(presentation_timeline)

func presentation_ended():
	Dialogic.timeline_ended.disconnect(presentation_ended)
	GlobalScore.mechanic_intro_shown=true
	show()
