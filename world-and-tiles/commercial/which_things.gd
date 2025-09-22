extends Node2D

func _ready() -> void:
	if GlobalScore.current_day==1:
		hide()
		$Which/Interactable/CollisionShape2D.disabled=true
