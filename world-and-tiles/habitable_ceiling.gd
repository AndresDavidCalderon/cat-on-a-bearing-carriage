extends Area2D

@onready var player=get_node("/root/World/Player")
@export var ceiling_material:ShaderMaterial

func _on_body_entered(body: Node2D) -> void:
	if body==player:
		get_car_sprite().material=ceiling_material
		player.z_index=1

func _on_body_exited(body: Node2D) -> void:
	if body==player:
		get_car_sprite().material=null
		player.z_index=0

func get_car_sprite()->Node2D:
	return player.get_node("Car/CarSprite")
