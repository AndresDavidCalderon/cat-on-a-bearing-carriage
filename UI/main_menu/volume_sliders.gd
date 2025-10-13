extends VBoxContainer

func _ready() -> void:
	update_slider_values()

func update_slider_values():
	Settings.set_value_to_volume_slider("Master",$Master/MasterSlider)
	Settings.set_value_to_volume_slider("Effects",$Effects/EffectSlider)
	Settings.set_value_to_volume_slider("Music",$Music/MusicSlider)


func _on_master_slider_value_changed(value: float) -> void:
	Settings.set_volume_to_value("Master",value)

func _on_effect_slider_value_changed(value: float) -> void:
	Settings.set_volume_to_value("Effects",value)


func _on_music_slider_value_changed(value: float) -> void:
	Settings.set_volume_to_value("Music",value)
