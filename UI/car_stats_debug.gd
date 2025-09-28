extends Control

@onready var player=get_node("/root/World/Player")


func _process(delta: float) -> void:
	$Label.text="Impulse: "+str(player.impulse)
	$Speed.text="Speed: "+str(player.speed)
	$SpeedMultiplier.text="Speed multiplier: "+str(player.speed_multiplier)
	$mapTarget.text="map target:"+str(get_parent().map_camera.get_target_position())
	$ImpulseReduction.text="Impulse reduction: "+player.debug_last_impulse_loss_type
