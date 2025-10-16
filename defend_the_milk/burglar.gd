extends AnimatableBody2D

enum State{
	APPROACHING_COW,
	MILKING,
	STORING_BOTTLE
}
@onready var defense_manager=get_node("/root/World/DefendTheMilk")

var current_state=State.APPROACHING_COW
var target_cow=null
var speed=20
var milking_time:float=10.0

## Goes from 0 to 1.
var milking_progress=0

func _process(delta: float) -> void:
	match current_state:
		State.APPROACHING_COW:
			if target_cow==null:
				target_cow=defense_manager.get_cow_assigned(self)
				if target_cow!=null:
					$NavigationAgent2D.target_position=target_cow.global_position
			if target_cow!=null:
				$NavigationAgent2D.velocity=global_position.direction_to($NavigationAgent2D.get_next_path_position())*speed
		State.MILKING:
			milking_progress+=delta/milking_time
			$Progress.value=milking_progress*100
			if milking_progress>1:
				current_state=State.STORING_BOTTLE
		


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	move_and_collide(safe_velocity)


func _on_navigation_agent_2d_navigation_finished() -> void:
	match current_state:
		State.APPROACHING_COW:
			current_state=State.MILKING
			$Progress.show()
