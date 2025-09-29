extends Control

var effect_shown:bool=false
var last_amount:int
var hide_speed=0.5
var time_since_effect=0
var min_time_since_effect=1

func _ready() -> void:
	update(false)
	GlobalScore.coins_changed.connect(update)

func _process(delta: float) -> void:
	if $WinEffect.modulate.a==0:
		effect_shown=false
	$WinEffect.modulate.a=clamp($WinEffect.modulate.a-hide_speed*delta,0,1)
	if not effect_shown:
		time_since_effect+=delta


func update(effect=true):
	$HBoxContainer/Label.text=str(GlobalScore.coins)
	if effect:
		var gained=GlobalScore.coins-last_amount
		if gained>0:
			$WinEffect/Stars.show()
			$WinEffect/Stars2.show()
			$WinEffect/Label.text="+"+str(gained)
			$WinEffect/Label.add_theme_color_override("font_color",Color("fff300"))
		else:
			$WinEffect/Stars.hide()
			$WinEffect/Stars2.hide()
			$WinEffect/Label.text=str(gained)
			$WinEffect/Label.add_theme_color_override("font_color",Color("80303a"))
			
		last_amount=GlobalScore.coins
		$WinEffect.modulate.a=1
		if time_since_effect>min_time_since_effect and not effect_shown:
			$WinEffect/FadeIn.play("fadeIN")
			time_since_effect=0
			effect_shown=true
