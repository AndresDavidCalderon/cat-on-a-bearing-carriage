extends AnimatableBody2D

signal path_ended

var speed=400
var target_idx=0
var margin=0
var rotation_speed=4
var acceptable_distance=10
var pathing=true

@export var path:Node

## If not empty, replaces path with a random one of here.
@export var possible_paths:Array[Node]

func _ready() -> void:
	if possible_paths.size()>0:
		path=possible_paths.pick_random()

func _process(delta: float) -> void:
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
		path_ended.emit()
