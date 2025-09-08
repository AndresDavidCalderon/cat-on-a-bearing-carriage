extends Control

@onready var target_provider=get_node("/root/World")
@onready var player=get_node("/root/World/Player") as Node2D
@export var color_transition:Gradient
var reference_distance=1500
func _process(delta: float) -> void:
	if target_provider.current_target!=null:
		var target=target_provider.current_target.position as Vector2
		rotation= target.angle_to_point(player.position)-player.rotation
		var distance_fraction=target.distance_to(player.position)/reference_distance
		distance_fraction=clamp(distance_fraction,0,1)
		modulate=color_transition.sample(1-distance_fraction)
