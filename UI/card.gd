extends Control

signal selected(blessing:int)

@export var texture_per_bless:Array[Texture]

var blessing:int


func _on_select_pressed() -> void:
	selected.emit(blessing)
	reveal()

func reveal():
	$AnimationPlayer.play("reveal")

func set_texture():
	$TextureRect.texture=texture_per_bless[blessing]
