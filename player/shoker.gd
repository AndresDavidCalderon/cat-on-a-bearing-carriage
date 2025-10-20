extends Node2D

signal shocked(bodies:Array)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shock"):
		$AnimationPlayer.play("shock")
		shocked.emit($IncidenceArea.get_overlapping_bodies())
