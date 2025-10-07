extends Area2D

@export var ceiling_material:ShaderMaterial

func _on_body_entered(body: Node2D) -> void:
	get_car_sprite().material=ceiling_material
func _on_body_exited(body: Node2D) -> void:
	get_car_sprite().material=null

func get_car_sprite()->Node2D:
	return get_node("/root/World/Player/Car/CarSprite")
