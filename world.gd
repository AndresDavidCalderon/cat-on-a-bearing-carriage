extends Node

@onready var minimap_viewport=$UI/Minimap/SubViewport

enum lossReason{
	TIME_OUT
}

enum matchState{
	PLAYING,
	WON,
	LOST,
	PREVIOUS,
	PAUSED
}

signal packet_delivered
signal loss(reason:lossReason)

## Sent by set_match_state
signal match_state_changed(new_state:matchState)
signal day_stats_set

## Emitted when winning. set_match_state doesnt emit this.
signal win

var current_match_state=matchState.PREVIOUS

var delivery_targets=[]

var current_target:Node=null
var next_target:Node=null
var packet_score:int=0
var base_milk_by_minute=3
var milk_by_minute_multiplier:float=1.3
var packet_target:int=10
var target_time=0
var remaining_time:float

func _ready() -> void:
	randomize()
	update_day_stats()

func _process(delta: float) -> void:
	if current_match_state==matchState.PLAYING:
		remaining_time-=delta
		if remaining_time<15:
			$Riff.pitch_scale=1.3
		if remaining_time<0:
			remaining_time=0
			current_match_state=matchState.LOST
			set_match_state(matchState.LOST)
			loss.emit(lossReason.TIME_OUT)

func register_target(target:Node):
	delivery_targets.append(target)


func _on_start_pressed() -> void:
	set_random_target()
	set_match_state(matchState.PLAYING)

func set_match_state(new_state:matchState):
	current_match_state=new_state
	match new_state:
		matchState.WON,matchState.LOST:
			var tween=create_tween()
			tween.tween_property($Riff,"volume_db",-40,0.5)
			tween.finished.connect(finish_song_fade)
		matchState.PLAYING:
			$Riff.play() 
		
	match_state_changed.emit(new_state)

func finish_song_fade():
	$Riff.playing=false
	match current_match_state:
		matchState.WON:
			$Win.play()
		matchState.LOST:
			$Loss.play()

func target_reached():
	packet_score+=1
	$Delivery.play()
	if packet_score<packet_target:
		set_random_target()
		packet_delivered.emit()
	else:
		set_match_state(matchState.WON)
		win.emit()

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
