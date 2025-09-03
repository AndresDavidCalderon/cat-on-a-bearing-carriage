extends CharacterBody2D

enum State{
	SLIDING,
	DRIFTING
}

enum Rotation{
	Negative,
	Positive
}

var current_state:State=State.SLIDING
@export var drift_point_offset:Vector2
@export var drift_movement:Vector2=Vector2(50,0)

# Spent when moving. Should be measured in pixels of distance.
var impulse:float=100
# Spends impulse.
var speed:float=impulse
@export var steering_speed:float=1

var pinpoint:Vector2 #Should be set when starting a drift.
var drift_direction:Rotation

func _process(delta: float) -> void:
	velocity=Vector2(0,-speed).rotated(rotation)
	move_and_slide()
	
	var circumstancial_steering_speed=steering_speed*delta
	if current_state==State.DRIFTING:
		circumstancial_steering_speed*=3
	
	if Input.is_action_pressed("SteerLeft"):
		rotation-=circumstancial_steering_speed
	if Input.is_action_pressed("SteerRight"):
		rotation+=circumstancial_steering_speed
	
	if Input.is_action_just_pressed("drift"):
		set_state(State.DRIFTING)
		pinpoint=position+drift_point_offset.rotated(rotation)
		if Input.is_action_pressed("SteerLeft"):
			drift_direction=Rotation.Negative
		if Input.is_action_pressed("SteerRight"):
			drift_direction=Rotation.Positive
	
	if Input.is_action_just_released("drift"):
		set_state(State.SLIDING)
	
	if current_state==State.DRIFTING:
		position=pinpoint-drift_point_offset.rotated(rotation)
		pinpoint+=drift_movement.rotated(rotation)*delta*(-1 if drift_direction==Rotation.Positive else 1)

func set_state(new_state:State):
	current_state=new_state
