extends Node2D

@onready var player = get_node("/root/World/Player")
@export var impulse=50
var speed_multiplier=1.4

var enabled=true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body==player and enabled:
		player.impulse+=impulse
		player.speed_multiplier*=speed_multiplier
		$SpeedTimer.start()
		disable()

func disable():
	modulate.a=0.2
	enabled=false
	$Timer.start()

func enable():
	modulate.a=1
	enabled=true

func _on_timer_timeout() -> void:
	enable()


func _on_speed_timer_timeout() -> void:
	player.speed_multiplier/=speed_multiplier
