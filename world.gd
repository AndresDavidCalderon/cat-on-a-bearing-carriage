extends Node
## Stores the match state, generic in the sense in that it
## shoudln't matter the game mode.
## at the moment it manages time remaining too.

enum lossReason{
	TIME_OUT
}

## Should contain all states, used in all game modes.
enum matchState{
	PLAYING,
	WON,
	LOST,
	PREVIOUS,
	PAUSED
}

## Called by the game mode manager for the UI to display
## the details of the current round's challenges. Could be optional
## but both delivery and defend call this.
signal round_stats_set
signal match_started
signal loss(reason:lossReason)

## Sent by set_match_state
signal match_state_changed(new_state:matchState)

## Emitted when winning. set_match_state doesnt emit this.
signal win


var current_match_state=matchState.PREVIOUS

## Should be set by the manager of the game mode.
var remaining_time:float

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	if current_match_state==matchState.PLAYING:
		remaining_time-=delta
		if remaining_time<15:
			$Riff.pitch_scale=1.3
		if remaining_time<0:
			$Riff.pitch_scale=1.0
			remaining_time=0
			current_match_state=matchState.LOST
			set_match_state(matchState.LOST)
			loss.emit(lossReason.TIME_OUT)


func _on_start_pressed() -> void:
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

func lost(loss_reason):
	loss.emit(loss_reason)



func _on_next_day_pressed() -> void:
	if GlobalScore.current_mode==GlobalScore.gameModes.DEFEND:
		GlobalScore.current_day+=1
		GlobalScore.current_mode=GlobalScore.gameModes.DELIVERY
		get_tree().reload_current_scene()
	else:
		GlobalScore.current_mode=GlobalScore.gameModes.DEFEND
		
		get_tree().reload_current_scene()
