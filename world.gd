extends Node

@onready var minimap_viewport=$UI/Minimap/SubViewport

enum lossReason{
	TIME_OUT
}


signal packet_delivered
signal loss(reason:lossReason)
signal match_state_changed(new_state:bool)
signal day_stats_set
signal win

var delivery_targets=[]

var current_target:Node=null
var packet_score:int=0
var base_milk_by_minute=4
var milk_by_minute_multiplier:float=1.3
var packet_target:int=10
var target_time=0
var remaining_time:float

var running:bool=false

func _ready() -> void:
	randomize()
	update_day_stats()

func _process(delta: float) -> void:
	if running:
		remaining_time-=delta
		if remaining_time<0:
			remaining_time=0
			running=false
			loss.emit(lossReason.TIME_OUT)

func register_target(target:Node):
	delivery_targets.append(target)


func _on_start_pressed() -> void:
	set_random_target()
	set_running(true)

func set_running(new_state:bool):
	running=new_state
	match_state_changed.emit(new_state)

func target_reached():
	packet_score+=1
	if packet_score<packet_target:
		set_random_target()
		packet_delivered.emit()
	else:
		set_running(false)
		win.emit()

func set_random_target():
	var new_target
	while new_target==current_target or new_target==null:
		new_target=delivery_targets.pick_random()
	set_current_target(new_target)

func set_current_target(target:Node2D):
	if current_target!=null:
		current_target.hide()
	if target!=null:
		target.show()
	current_target=target

func lost(loss_reason):
	set_current_target(null)
	loss.emit(loss_reason)

func update_day_stats():
	target_time = randi_range(45,120)
	var minutes:float=(target_time/60.0)
	packet_target = round(minutes*base_milk_by_minute*pow(milk_by_minute_multiplier,GlobalScore.current_day-1))
	day_stats_set.emit()
	remaining_time=target_time


func _on_next_day_pressed() -> void:
	GlobalScore.current_day+=1
	get_tree().reload_current_scene()
