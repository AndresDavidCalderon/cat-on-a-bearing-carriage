extends Control

@onready var match_provider=get_parent().get_parent()
@onready var bless_manager=get_node("/root/World/Blessings")
@export var card:PackedScene
@export var timeline:DialogicTimeline

var selected:int
func _ready() -> void:
	hide()

func start_session():
	Dialogic.start(timeline)
	match_provider.set_match_state(match_provider.matchState.PAUSED)
	
	return
	show()
	for i in range(2):
		var instance=card.instantiate()
		$Cards.add_child(instance)
		var type=randi_range(0,Blessings.BlessType.size()-1)
		card.blessing=type
		card.selected.connect(on_card_picked)
	$Panel/Label.text="Choose a card"

func on_card_picked(blessing:int):
	selected=blessing
	$Panel/Ok.show()
	var description:String
	match selected:
		Blessings.BlessType.EXTRA_TIME_30_SEC:
			description="You gain 30 seconds!"
		Blessings.BlessType.EXTRA_TIME_60_SEC:
			description="You gain 60 seconds!"
		Blessings.BlessType.NEXT_POINT_PREDICTION:
			description="You will be able to see where the next delivery will be after the one you are doing."
		Blessings.BlessType.LESS_DELIVERY_2:
			description="You will have to deliver 2 bottles less."
		Blessings.BlessType.DISTANCE_DELIVERY:
			description="You'll be able to deliver milk from 3 times farther away than normal"
		Blessings.BlessType.STOP_DRIFT:
			description="Drifting will no longer make your car slide."

func _on_ok_pressed() -> void:
	bless_manager.start_bless(selected)
	hide()
	for i in $Cards.get_children():
		i.queue_free()
