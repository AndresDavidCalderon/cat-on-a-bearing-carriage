extends SubViewportContainer

func _ready() -> void:
	get_viewport().set_canvas_cull_mask_bit(1,false)
