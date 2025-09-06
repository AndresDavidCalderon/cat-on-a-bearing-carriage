extends Control

@onready var player=get_node("/root/World/Player")


func _process(delta: float) -> void:
	$Label.text="Impulse: "+str(player.impulse)
	$Speed.text="Speed: "+str(player.speed)
	$SpeedMultiplier.text="Speed multiplier: "+str(player.speed_multiplier)
