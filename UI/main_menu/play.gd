extends Control

var played=false

func _on_visibility_changed() -> void:
	if visible and not played:
		$AnimatedSprite2D.play("start")


func _on_animated_sprite_2d_animation_finished() -> void:
	played=true
	$AnimatedSprite2D.play("loop")
