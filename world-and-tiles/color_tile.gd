extends Node2D
@export var colors:Array[Color]

func _ready() -> void:
	var time = randf_range(0.6,1)
	$Timer.wait_time=time
	$Timer.start()

func _on_timer_timeout() -> void:
	var new_color=colors.pick_random()
	$Color.modulate=new_color
	$PointLight2D.modulate=new_color
