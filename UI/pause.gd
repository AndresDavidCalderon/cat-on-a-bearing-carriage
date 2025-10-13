extends Control

@onready var match_provider=get_node("/root/World")

## If true, the game should unpause when hiding.
## not true if pausing on a dialogue for example.
var controls_time_pause=false
var state_before:int

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if visible:
			unpause()
		else:
			pause()
	
func _on_resume_pressed() -> void:
	unpause()

func unpause():
	if controls_time_pause:
		match_provider.set_match_state(state_before)
	hide()
	get_tree().paused=false
	

func pause():
	if match_provider.current_match_state!= match_provider.matchState.PAUSED:
		match_provider.set_match_state(match_provider.matchState.PAUSED)
		controls_time_pause=true
	show()
	get_tree().paused=true

	Settings.set_value_to_volume_slider("Master",$Panel/SoundOptions/Master/MasterSlider)
	Settings.set_value_to_volume_slider("Music",$Panel/SoundOptions/Music/MusicSlider)
	Settings.set_value_to_volume_slider("Effects",$Panel/SoundOptions/Effects/EffectSlider)

func _on_restart_day_pressed() -> void:
	unpause()
	get_tree().reload_current_scene()


func _on_master_slider_value_changed(value: float) -> void:
	Settings.set_volume_to_value("Master",value)

func _on_effect_slider_value_changed(value: float) -> void:
	Settings.set_volume_to_value("Effects",value)


func _on_music_slider_value_changed(value: float) -> void:
	Settings.set_volume_to_value("Music",value)
