extends Node2D

@export var presentation_timeline:DialogicTimeline
@onready var mechanic_ui:Control=get_node("/root/World/UI/Mechanic")

func _ready() -> void:
	if GlobalScore.current_day<=GlobalScore.mechanic_day:
		hide()

func _on_mechanic_delivered() -> void:
	if GlobalScore.current_day==GlobalScore.mechanic_day:
		get_parent().set_match_state(get_parent().matchState.PAUSED)
		Dialogic.timeline_ended.connect(presentation_ended)
		Dialogic.start(presentation_timeline)

func presentation_ended():
	Dialogic.timeline_ended.disconnect(presentation_ended)
	GlobalScore.mechanic_intro_shown=true
	show()
	mechanic_ui.start()


func _on_interactable_interacted() -> void:
	mechanic_ui.start()
