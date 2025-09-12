extends StaticBody2D

func _ready() -> void:
	var timer=get_tree().create_timer(randf_range(15,90))
	timer.timeout.connect(kiss)

func kiss():
	$AnimatedSprite2D.play("Kiss")
	var timer=get_tree().create_timer(randf_range(15,90))
	timer.timeout.connect(kiss)
