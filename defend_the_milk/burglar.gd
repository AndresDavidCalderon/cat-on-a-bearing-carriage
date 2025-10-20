extends AnimatableBody2D

enum State{
	APPROACHING_COW,
	MILKING,
	STORING_BOTTLE,
	KO ## KO means defeated.
}
@onready var defense_manager=get_node("/root/World/DefendTheMilk")
@onready var player=get_node("/root/World/Player")

var debug_modulate_cow=false
var current_state=State.APPROACHING_COW
var target_cow=null
var target_truck=null
var speed=5
var milking_time:float=10.0
var min_ko_speed=500
var milk_stolen_success=false
var snap_to_cow=false

## Goes from 0 to 1.
var milking_progress=0

func _ready() -> void:
	player.hit.connect(on_player_hit)
	set_state(State.APPROACHING_COW)

func _physics_process(delta: float) -> void:
	match current_state:
		State.APPROACHING_COW:
			if target_cow==null:
				target_cow=defense_manager.get_cow_assigned(self)
				if target_cow!=null:
					$NavigationAgent2D.target_position=target_cow.global_position
					if debug_modulate_cow:
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
				target_cow.end_milking()
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
	rotation=safe_velocity.angle()+PI/2

func on_player_hit(colission,_is_first):
	if colission.get_collider()==self:
		if player.speed>min_ko_speed:
			match current_state:
				State.MILKING:
					defense_manager.assigned_cows.erase(self)
					defense_manager.avaliable_cows.append(target_cow)
			$CollisionShape2D.set_deferred("disabled",true)
			$NavigationAgent2D.avoidance_enabled=false
			set_state(State.KO)
			

func _on_navigation_agent_2d_navigation_finished() -> void:
	match current_state:
		State.APPROACHING_COW:
			set_state(State.MILKING)
			$Progress.show()
			if snap_to_cow:
				global_position=target_cow.get_node("MilkingPosition").global_position
				rotation=global_position.angle_to_point(target_cow.global_position)
			target_cow.start_milking()
		State.STORING_BOTTLE:
			if not milk_stolen_success:
				defense_manager.lose_bottle()
				milk_stolen_success=true
			queue_free()

func set_state(new_state:State):
	current_state=new_state
	$CurrentState.text=State.find_key(new_state)
	match new_state:
		State.APPROACHING_COW:
			$Sprite2D.play("Walking")
		State.MILKING:
			$Sprite2D.play("Milking")
		State.STORING_BOTTLE:
			$Sprite2D.play("Walking")
			$Milk.play("Walking")
			$Milk.show()
		State.KO:
			queue_free()


func _on_re_check_cow_position_timeout() -> void:
	if current_state==State.APPROACHING_COW:
		$NavigationAgent2D.target_position=target_cow.global_position
