extends TileMapLayer

func _ready() -> void:
	if not visible:
		self_modulate.a=0
		show()
