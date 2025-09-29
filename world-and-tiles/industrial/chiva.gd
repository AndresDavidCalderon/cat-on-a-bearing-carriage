extends AnimatableBody2D

var speed=400
var target_idx=0
var margin=0
var rotation_speed=3
var acceptable_distance=10
var pathing=true

@export var path:Node


func _physics_process(delta: float) -> void:
	if path.get_child_count()<=target_idx or not pathing:
		return
	var target_position=path.get_child(target_idx).global_position
	var target_rotation=global_position.angle_to_point(target_position)+PI/2
	rotation=rotate_toward(rotation,target_rotation,rotation_speed*delta)
	var motion=global_position.direction_to(target_position)*speed*delta
	move_and_collide(motion)
	if global_position.distance_to(target_position)<=acceptable_distance:
		done_with_target()

func done_with_target():
	if target_idx<path.get_child_count()-1:
		target_idx+=1
	else:
		pathing=false
