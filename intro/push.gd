extends Control


func _on_mouse_entered() -> void:
	$TextureRect.play()


func _on__visibility_changed() -> void:
	$TextureRect.play()
