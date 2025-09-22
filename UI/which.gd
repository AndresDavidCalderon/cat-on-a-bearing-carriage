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
	Dialogic.signal_event.connect(on_timeline_signal)

func on_timeline_signal(argument:String):
	match argument:
		"DISPLAY_CARDS":
			show()
			selection_pending=true
			for i in range(2):
				var instance=card.instantiate()
				$Cards.add_child(instance)
				var type=bless_manager.avaliable_blessings.pick_random()
				instance.blessing=type
				instance.selected.connect(on_card_picked)
			$Cards.adjust_layout()
		"WITCH_NEGATIVE_END":
			match_provider.set_match_state(match_provider.matchState.PLAYING)
			Dialogic.signal_event.disconnect(on_timeline_signal)
		"WITCH_RECIEVE_END":
			match_provider.set_match_state(match_provider.matchState.PLAYING)
			bless_manager.start_blessing(selected)
			Dialogic.signal_event.disconnect(on_timeline_signal)
			for i in $Cards.get_children():
				i.queue_free()
			hide()
		"BUY_BLESSING":
			GlobalScore.set_coins(GlobalScore.coins-Blessings.cost)

func on_card_picked(blessing:int):
	selected=blessing
	selection_pending=false
	Dialogic.VAR.set_variable("BLESS",Blessings.BlessType.keys()[blessing])
	Dialogic.start(end_timeline)
