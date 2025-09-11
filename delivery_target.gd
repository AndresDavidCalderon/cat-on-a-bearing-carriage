extends Node2D

func _ready() -> void:
	get_node("/root/World").register_target(self)
	hide()

func _on_area_body_entered(body: Node2D) -> void:
	if body==get_node("/root/World/Player"):
		if get_node("/root/World").current_target==self:
			get_node("/root/World").target_reached()
	
