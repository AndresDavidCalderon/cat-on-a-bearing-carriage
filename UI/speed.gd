extends ProgressBar

@onready var player=get_node("/root/World/Player")
@export var coin_color:Color

var offset=-500
var value_100=800
var time_after_100=0
var duplicate_after=2
var triplicate_afer=8
var coins_after=80
var was_under=true

func _process(delta: float) -> void:
	value=((player.speed+offset)/value_100)*100
	$Label.text=str(int(value))
	if value>coins_after:
		self_modulate=coin_color
		time_after_100+=delta
		if was_under:
			$CoinCheck.start()
		was_under=false
	else:
		was_under=true
		self_modulate=Color.WHITE
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
