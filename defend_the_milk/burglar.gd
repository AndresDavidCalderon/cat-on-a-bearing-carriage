extends AnimatableBody2D

enum State{
	APPROACHING_COW,
	MILKING,
	STORING_BOTTLE
}
@onready var defense_manager=get_node("/root/World/DefendTheMilk")

var current_state=State.APPROACHING_COW
var target_cow=null
var target_truck=null
var speed=5
var milking_time:float=10.0

## Goes from 0 to 1.
var milking_progress=0

func _physics_process(delta: float) -> void:
	match current_state:
		State.APPROACHING_COW:
			if target_cow==null:
				target_cow=defense_manager.get_cow_assigned(self)
				if target_cow!=null:
					$NavigationAgent2D.target_position=target_cow.global_position
					var color=Color(randf(),randf(),randf())
					$Sprite2D.self_modulate=color
					target_cow.modulate=color
			if target_cow!=null:
				simple_set_velocity()
		State.MILKING:
			milking_progress+=delta/milking_time
			$Progress.value=milking_progress*100
			if milking_progress>1:
				set_state(State.STORING_BOTTLE)
		State.STORING_BOTTLE:
			if $NavigationAgent2D.is_navigation_finished():
				target_truck=defense_manager.get_node("DeliveryTrucks").get_children().pick_random()
				$NavigationAgent2D.target_position=target_truck.global_position
			simple_set_velocity()

func simple_set_velocity():
	var velocity=global_position.direction_to($NavigationAgent2D.get_next_path_position())*speed
	if $NavigationAgent2D.avoidance_enabled:
		$NavigationAgent2D.velocity=velocity
	else:
		_on_navigation_agent_2d_velocity_computed(velocity)

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	position+=safe_velocity


func _on_navigation_agent_2d_navigation_finished() -> void:
	match current_state:
		State.APPROACHING_COW:
			set_state(State.MILKING)
			$Progress.show()
		State.STORING_BOTTLE:
			queue_free()

func set_state(new_state:State):
	current_state=new_state
	$CurrentState.text=State.find_key(new_state)
