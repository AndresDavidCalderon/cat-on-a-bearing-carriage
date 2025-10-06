extends Node

## Useful because splashs don't follow the car.
@onready var offset_l=$SplashLeft.position
@onready var offset_r=$SplashRight.position
@onready var offset_sprinkle_l=$SprinkleL.position
@onready var offset_sprinkle_r=$SprinkleR.position

func _on_player_drift_started() -> void:
	if Weather.get_weather_today()!=Weather.Weather.RAINY:
		return
	
	
	var relevant:AnimatedSprite2D
	var offset:Vector2
	if get_parent().drift_direction==get_parent().Rotation.POSITIVE:
		relevant=$SplashLeft
		offset=offset_l
		$SprinkleL.global_position=get_parent().global_position+offset_sprinkle_l
		$SprinkleL.rotation=get_parent().rotation
		$SprinkleL.play()
	else:
		relevant=$SplashRight
		offset=offset_r
		$SprinkleR.play()
		$SprinkleR.global_position=get_parent().global_position+offset_sprinkle_r
		$SprinkleR.rotation=get_parent().rotation
	if relevant!=null:
		relevant.show()
		relevant.play()
		relevant.rotation=get_parent().rotation
		relevant.global_position=get_parent().global_position+offset


func _on_splash_right_animation_finished() -> void:
	$SplashRight.hide()

func _on_splash_left_animation_finished() -> void:
	$SplashLeft.hide()
