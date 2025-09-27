extends Control

@onready var player=get_node("/root/World/Player")
@export var coin_color:Color
@export var normal_color:Color

# Applied over the player's speed. A logarithm base 10 is applied after
var offset=-500 

## Exchange rate from player speed to value.
## This, in sqrt(speed) represents a value of 100
var value_100=326
var time_after_100=0
var duplicate_after=2
var triplicate_afer=8
var coins_after=100
var was_under=true
var value:float
var max_value=125
var rotation_speed=3
var last_delta=0

# Rotation when effective value=dwdmax value
var total_rotation=PI

func _process(delta: float) -> void:
	last_delta=delta
	var curved_speed=float(max(player.speed+offset,0))**0.9
	set_value((curved_speed/value_100)*100)
	$Label.text=str(int(value))
	if value>coins_after:
		$Tick.self_modulate=coin_color
		time_after_100+=delta
		if was_under:
			$CoinCheck.start()
		was_under=false
	else:
		was_under=true
		$Tick.self_modulate=normal_color
		time_after_100=0
		$CoinCheck.stop()


func _on_coin_check_timeout() -> void:
	if value>coins_after and player.get_parent().current_match_state==player.get_parent().matchState.PLAYING:
		var circumstancial_price=1
		if time_after_100>duplicate_after:
			circumstancial_price*=2
		if time_after_100>triplicate_afer:
			circumstancial_price*=3
		GlobalScore.set_coins(GlobalScore.coins+circumstancial_price)

func set_value(new_value):
	value=max(new_value,0)
	var effective_value=min(max_value,value)
	$Tick.rotation= rotate_toward($Tick.rotation,(effective_value/max_value)*total_rotation,rotation_speed*last_delta)
