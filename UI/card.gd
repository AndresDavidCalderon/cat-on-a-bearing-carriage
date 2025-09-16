extends Control

signal selected(blessing:int)

var blessing:int



func _on_select_pressed() -> void:
	selected.emit(blessing)
