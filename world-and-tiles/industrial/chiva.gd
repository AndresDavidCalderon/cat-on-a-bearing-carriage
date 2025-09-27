extends AnimatableBody2D

var speed=10
var target_idx=0
var margin=0
var rotation_speed=1

@export var path:Node


func _physics_process(delta: float) -> void:
	if path.get_child_count()<=target_idx:
		return
	var target_position=path.get_child(target_idx).global_position
	var target_rotation=global_position.angle_to_point(global_position)
	rotation=lerp_angle(rotation,target_rotation,rotation_speed*delta)
	var motion=global_position.direction_to(target_position)*speed*delta
	move_and_collide(motion)
