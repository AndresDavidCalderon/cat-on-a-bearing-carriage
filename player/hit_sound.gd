extends Node

var standard_speed_for_hit_hard_pitch=600
var standard_speed_for_soft=550
var hard_to_soft=700
var hit_sound_offset=-15
var min_speed_for_effect=400

func _on_player_hit() -> void:
	if get_parent().speed>hard_to_soft:
		$HitHard.play()
		$HitHard.pitch_scale=standard_speed_for_hit_hard_pitch/get_parent().speed
		$HitHard.volume_db=(standard_speed_for_hit_hard_pitch/get_parent().speed)**2+hit_sound_offset
	else:
		$HitSoft.pitch_scale=standard_speed_for_soft/max(get_parent().speed,min_speed_for_effect)
		$HitSoft.play()
