extends Control

@onready var match_provider=get_parent().get_parent()
@onready var bless_manager:Blessings=get_node("/root/World/Blessings")
@export var card:PackedScene
@export var timeline:DialogicTimeline
@export var end_timeline:DialogicTimeline

var selected:int=-1
var selection_pending=false
func _ready() -> void:
	hide()

func start_session():
	selected=-1
	match_provider.set_match_state(match_provider.matchState.PAUSED)
	Dialogic.start(timeline)
	Dialogic.timeline_ended.connect(on_end_first_timeline)
	Dialogic.signal_event.connect(on_timeline_signal)
	show()

func on_timeline_signal(argument:String):
	show()
	selection_pending=true
	for i in range(2):
		var instance=card.instantiate()
		$Cards.add_child(instance)
		var type=randi_range(0,Blessings.BlessType.size()-1)
		instance.blessing=type
		instance.selected.connect(on_card_picked)

func on_card_picked(blessing:int):
	selected=blessing
	selection_pending=false
	for i in $Cards.get_children():
		i.queue_free()
	Dialogic.VAR.set_variable("BLESS",Blessings.BlessType.keys()[blessing])
	Dialogic.start(end_timeline)
	Dialogic.timeline_ended.connect(on_second_timeline_ended)
	Dialogic.signal_event.disconnect(on_timeline_signal)

func on_second_timeline_ended():
	match_provider.set_match_state(match_provider.matchState.PLAYING)
	bless_manager.start_blessing(selected)
	Dialogic.timeline_ended.disconnect(on_second_timeline_ended)

func on_end_first_timeline():
	if not selection_pending:
		end_no_card()
	Dialogic.timeline_ended.disconnect(on_end_first_timeline)

func end_no_card():
	match_provider.set_match_state(match_provider.matchState.PLAYING)
	hide()
	Dialogic.signal_event.disconnect(on_timeline_signal)
