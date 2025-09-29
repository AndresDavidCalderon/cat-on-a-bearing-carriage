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
var rotation_speed=20
var last_delta:float
var give_way:bool

func _ready() -> void:
	set_new_target()
	$NavigationAgent2D.avoidance_priority=randf_range(0.2,0.8)

func _process(delta: float) -> void:
	last_delta=delta
	if $NavigationAgent2D.is_navigation_finished() or match_provider.current_match_state!=match_provider.matchState.PLAYING:
		return
	match current_state:
		State.GOING:
			var target=$NavigationAgent2D.get_next_path_position()
			var new_velocity=global_position.direction_to(target)*speed*delta
			if $NavigationAgent2D.avoidance_enabled:
				$NavigationAgent2D.set_velocity(new_velocity)
			else:
				_on_navigation_agent_2d_velocity_computed(new_velocity)

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	move_and_collide(safe_velocity)
	rotation=rotate_toward(rotation,safe_velocity.angle()+PI/2,rotation_speed*last_delta)


func _on_navigation_agent_2d_navigation_finished() -> void:
	$AttentionSpan.start()

func set_new_target():
	$NavigationAgent2D.target_position=get_parent().get_node("InterestPoints").get_children().pick_random().global_position


func _on_attention_span_timeout() -> void:
	set_new_target()
