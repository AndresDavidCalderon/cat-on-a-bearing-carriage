extends Node

signal packet_delivered


@export var mechanic_point:Node
var mechanic_delivery_turn=3

var delivery_targets=[]

var current_target:Node=null
var next_target:Node=null
var packet_score:int=0
var base_milk_by_minute=3
var milk_by_minute_multiplier:float=1.3
var packet_target:int=10
var target_time=0

func _ready() -> void:
	if GlobalScore.current_mode==GlobalScore.gameModes.DELIVERY:
		update_day_stats()

func register_target(target:Node):
	delivery_targets.append(target)


func update_day_stats():
	if GlobalScore.current_day!=GlobalScore.mechanic_day:
		target_time = randi_range(45,120)
	else:
		target_time=120
	
	var minutes:float=(target_time/60.0)
	packet_target = round(minutes*base_milk_by_minute*pow(milk_by_minute_multiplier,GlobalScore.current_day-1))
	get_parent().remaining_time=target_time
	get_parent().round_stats_set.emit()
	set_random_target()

func target_reached():
	packet_score+=1
	$Delivery.play()
	if packet_score<packet_target:
		set_random_target()
		packet_delivered.emit()
	else:
		get_parent().set_match_state(get_parent().matchState.WON)
		get_parent().win.emit()

func set_random_target():
	if next_target!=null:
		set_current_target(next_target)
		if packet_score<=packet_target-2:
			next_target=generate_random_target()
		else:
			next_target=null
	else:
		set_current_target(generate_random_target())
		next_target=generate_random_target()

func generate_random_target():
	if GlobalScore.current_day==GlobalScore.mechanic_day:
		if mechanic_point in delivery_targets:
			delivery_targets.erase(mechanic_point)
		if packet_score==mechanic_delivery_turn-2:
			return mechanic_point
	
	var new_target=null
	while new_target==current_target or new_target==null:
		new_target=delivery_targets.pick_random()
	return new_target

func set_current_target(target:Node2D):
	if current_target!=null:
		current_target.hide()
	if target!=null:
		target.show()
		target.enable()
	current_target=target


func _on_world_time_ran_out() -> void:
	get_parent().loss.emit(get_parent().lossReason.TIME_OUT)
	get_parent().set_match_state(get_parent().matchState.LOST)
