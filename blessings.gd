extends Node
class_name Blessings

enum BlessType{
	EXTRA_TIME_30_SEC,
	EXTRA_TIME_60_SEC,
	NEXT_POINT_PREDICTION,
	LESS_DELIVERY_2,
	DISTANCE_DELIVERY,
	STOP_DRIFT
}

@export var delivery_target_shape:Shape2D
static var cost=50
var prediction=false
var stop_drift=false

var avaliable_blessings=BlessType.values()

func start_blessing(what:BlessType):
	match what:
		BlessType.EXTRA_TIME_30_SEC:
			get_parent().remaining_time+=30
		BlessType.EXTRA_TIME_60_SEC:
			get_parent().remaining_time+=60
		BlessType.NEXT_POINT_PREDICTION:
			prediction=true
			update_prediction()
			get_parent().packet_delivered.connect(update_prediction)
		BlessType.LESS_DELIVERY_2:
			get_parent().packet_target-=2
			if get_parent().packet_score>get_parent().packet_target:
				get_parent().set_match_state(get_parent().matchState.WON)
				get_parent().win.emit()
			get_parent().day_stats_set.emit()
		BlessType.DISTANCE_DELIVERY:
			delivery_target_shape.size.x*=3
			delivery_target_shape.size.y*=3
			for i in get_parent().delivery_targets:
				i.get_node("VisibleTarget").scale*=3
		BlessType.STOP_DRIFT:
			stop_drift=true
	avaliable_blessings.erase(what)

func update_prediction():
	if get_parent().next_target==null:
		$NextTarget.hide()
	else:
		$NextTarget.position=get_parent().next_target.position
		$NextTarget.show()
