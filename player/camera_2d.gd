extends Camera2D

var standard_zoom=Vector2(1,1)
var defend_zoom=Vector2(1,1)
var alteration=Vector2(-0.01,0.015)
var position_alteration=Vector2(0,5)
var presses=0
var max_presses=7
var max_zoom_alteration=0.3
var back_to_normal_zoom=0.3
var time_without_presses=0
var back_to_normal_after=0.5

var tween:Tween
var going_back=false

func _ready() -> void:
	if GlobalScore.current_mode==GlobalScore.gameModes.DEFEND:
		standard_zoom=defend_zoom
	zoom=standard_zoom

func _process(delta: float) -> void:
	if time_without_presses>back_to_normal_after:
		if not going_back:
			presses=0
			if tween!=null:
				tween.stop()
			tween=create_tween()
			tween.tween_property(self,"zoom",standard_zoom,back_to_normal_zoom)
			tween.tween_property(self,"position",Vector2.ZERO,back_to_normal_zoom)
			going_back=true
	else:
		time_without_presses+=delta
		going_back=false

func _on_player_impulsed() -> void:
	if presses<max_presses:
		presses+=1
	if tween!=null:
		tween.stop()
	tween=create_tween()
	tween.tween_property(self,"zoom",standard_zoom+alteration*presses,0.1)
	tween.tween_property(self,"position",position_alteration*presses,0.1)
	time_without_presses=0
