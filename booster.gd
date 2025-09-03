extends Node2D

@onready var player = get_node("/root/World/Player")
@export var impulse=50

var enabled=true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body==player and enabled:
		player.impulse+=impulse
		disable()

func disable():
	modulate.a=0.3
	enabled=false
	$Timer.start()

func enable():
	modulate.a=1
	enabled=true

func _on_timer_timeout() -> void:
	enable()
