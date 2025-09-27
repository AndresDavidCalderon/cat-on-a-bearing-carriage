extends Node2D

@export var possible_textures:Array[Texture]

func _ready() -> void:
	$Sprite2D.texture=possible_textures.pick_random()
	var tween=create_tween()
	tween.tween_property(self,"modulate:a",0,0.5)
	tween.finished.connect(queue_free)
