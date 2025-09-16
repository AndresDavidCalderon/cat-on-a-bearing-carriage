extends ProgressBar

@onready var player=get_node("/root/World/Player")
@export var coin_color:Color

var offset=-500
var value_100=800

func _process(delta: float) -> void:
	value=((player.speed+offset)/value_100)*100
	$Label.text=str(int(value))
	if value>100:
		self_modulate=coin_color
	else:
		self_modulate=Color.WHITE
