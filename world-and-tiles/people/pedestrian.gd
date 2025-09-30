extends AnimatableBody2D
class_name Pedestrian

enum State{
	WAITING,
	GIVING_WAY,
	GOING
}
var current_state=State.GOING

@onready var match_provider=get_node("/root/World")


var speed=200
var give_way_speed=100
var rotation_speed=20
var last_delta:float
var give_way_angle:float=0
var angle_give_way_offset_p_second:float=0

## Can be managed by another pedestrian if they find the intersection first.
## they must change it back to true after finding we are no longer in their way.
var give_way:bool=true

## Useful for managing the other pedestrian's give way state.
var giving_way_to:Pedestrian

## Latest velocity used.
var move_intention:Vector2


func _ready() -> void:
	set_new_target()
	$NavigationAgent2D.avoidance_priority=randf_range(0.2,0.8)

func _process(delta: float) -> void:
	last_delta=delta
	$Debug/MoveIntention.rotation=move_intention.angle()
	$Debug.rotation=-rotation
	if $NavigationAgent2D.is_navigation_finished() or match_provider.current_match_state!=match_provider.matchState.PLAYING:
		return
	
	match current_state:
		State.GOING:
			var target=$NavigationAgent2D.get_next_path_position()
			var new_velocity=global_position.direction_to(target)*speed*delta
			move_intention=new_velocity
			if give_way:
				for i in $WayArea.get_overlapping_bodies():
					if i is Pedestrian:
						i.give_way=false
						current_state=State.GIVING_WAY
						giving_way_to=i
						give_way_angle=i.move_intention.angle()+PI/2
						break
			if $NavigationAgent2D.avoidance_enabled:
				$NavigationAgent2D.set_velocity(new_velocity)
			else:
				_on_navigation_agent_2d_velocity_computed(new_velocity)
			
			give_way_angle=rotate_toward(give_way_angle,0,angle_give_way_offset_p_second*delta)
			
		State.GIVING_WAY:
			give_way_angle+=angle_give_way_offset_p_second*delta
			var give_way_vector=Vector2(0,1).rotated(give_way_angle)*give_way_speed*delta
			move_and_collide(give_way_vector)
			move_intention=give_way_vector
			if not pedestrians_in_area().has(giving_way_to):
				giving_way_to.give_way=true
				current_state=State.GOING
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	move_and_collide(safe_velocity)
	rotation=rotate_toward(rotation,safe_velocity.angle()+PI/2,rotation_speed*last_delta)


func _on_navigation_agent_2d_navigation_finished() -> void:
	$AttentionSpan.start()

func set_new_target():
	$NavigationAgent2D.target_position=get_parent().get_node("InterestPoints").get_children().pick_random().global_position

func pedestrians_in_area():
	var pedestrians=[]
	for i in $WayArea.get_overlapping_bodies():
		if i is Pedestrian:
			pedestrians.append(i)
	return pedestrians

func is_pedestrian(a):
	return a is Pedestrian

func _on_attention_span_timeout() -> void:
	set_new_target()
