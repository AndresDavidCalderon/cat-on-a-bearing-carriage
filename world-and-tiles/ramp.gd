extends Line2D

@onready var player=get_node("/root/World/Player")

var affecting=false




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body==player:
		affecting=true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body==player:
		affecting=true
