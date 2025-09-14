extends CharacterBody2D

enum State{
	SLIDING,
	DRIFTING
}

enum Rotation{
	Negative,
	Positive
}
var speed_multiplier=1
var current_state:State=State.SLIDING
@export var drift_point_offset:Vector2=Vector2(0,-12)
@export var drift_movement:Vector2=Vector2(1,0)
@export var speed_to_drift:float=0.4 # Multiplies how much the car slides, relative to its original speed before
# drift.

@export var impulse_loss=30
var impulse_loss_critic=0.1
var critic_fast_treshhold=1000
var impulse_per_tap=40
var grace_time_after_tap=1

# Critically low speed, should increase impulse per tap.
var critic_treshhold=100
var critic_impulse_per_tap=300
var tap_speed_multiplier=1.1
var critic_tap_speed_mutiplier=2
var tap_speed_duration=1
var time_since_tap=0

# Spent when moving. Should be measured in pixels of distance.
var impulse:float=600
# Spends impulse.
var speed:float=impulse
@export var steering_speed:float=1.5
@export var drifting_steering_speed=3
var break_force=500
var breaking_enabled=false

var pinpoint:Vector2 #Should be set when starting a drift.
var drift_direction:Rotation
var was_separated=true
var was_straight=false
var standard_speed_for_hit_soft_pitch=600
var hit_sound_offset=-15
var hard_to_soft=700

var texture_overriden=false
var impulse_texture_override_length=1

@export var cat_drift:Texture
@export var cat_push:Texture
@export var cat_default:Texture

func _process(delta: float) -> void:
	if get_parent().running:
		if not texture_overriden:
			$Cat.texture=cat_default
		velocity=Vector2(0,-speed).rotated(rotation)
		var collided = move_and_slide()
		if collided:
			if was_separated:
				if speed>hard_to_soft:
					$HitHard.play()
					$HitHard.pitch_scale=standard_speed_for_hit_soft_pitch/speed
					$HitHard.volume_db=(standard_speed_for_hit_soft_pitch/speed)**2+hit_sound_offset
				else:
					$HitSoft.play()
			was_separated=false
		else:
			was_separated=true
		
		if time_since_tap>grace_time_after_tap:
			if impulse<critic_fast_treshhold:
				impulse-=impulse_loss*delta
			else:
				impulse-=impulse*impulse_loss_critic*delta
				print("critic speed")
		speed=impulse*speed_multiplier
	
		if impulse<=0:
			impulse=0
		
		var circumstancial_steering_speed=steering_speed*delta
		
		time_since_tap+=delta
		
		# Simple sliding rotation logic, rotating on drift requires more collission checks
		if current_state==State.SLIDING:
			var turning=false
			if Input.is_action_pressed("SteerLeft"): 
				rotation-=circumstancial_steering_speed
				turning=true
			if Input.is_action_pressed("SteerRight"):
				rotation+=circumstancial_steering_speed
				turning=true
			if Input.is_action_just_pressed("impulse"):
				var multiplier
				if impulse>critic_treshhold:
					impulse+=impulse_per_tap
					multiplier=tap_speed_multiplier
				else:
					impulse+=critic_impulse_per_tap
					multiplier=critic_tap_speed_mutiplier
				speed_multiplier*=multiplier
				var timer =get_tree().create_timer(tap_speed_duration)
				timer.timeout.connect(revert_speed.bind(multiplier))
				texture_overriden=true
				$Cat.texture=cat_push
				var texture_timer=get_tree().create_timer(impulse_texture_override_length)
				texture_timer.timeout.connect(impulse_texture_end)
				time_since_tap=0
				$Impulse.play()
			if turning:
				if was_straight:
					$Turn.play()
				was_straight=false
			else:
				was_straight=true
		
		if Input.is_action_just_pressed("drift"):
			set_state(State.DRIFTING)
			$Drift.play()
			pinpoint=position+drift_point_offset.rotated(rotation)
			if Input.is_action_pressed("SteerLeft"):
				drift_direction=Rotation.Negative
			if Input.is_action_pressed("SteerRight"):
				drift_direction=Rotation.Positive
		
		if Input.is_action_just_released("drift"):
			set_state(State.SLIDING)
		
		if current_state==State.DRIFTING:
			var circumstantial_drift_slide=drift_movement.rotated(rotation)*speed*speed_to_drift
			position=pinpoint-drift_point_offset.rotated(rotation)
			var relevant_area:Area2D
			if drift_direction==Rotation.Negative:
				relevant_area=$Right
			else:
				relevant_area=$Left
			if not has_relevant_bodies(relevant_area):
				pinpoint+=circumstantial_drift_slide*delta*(-1 if drift_direction==Rotation.Positive else 1)
			
			if Input.is_action_pressed("SteerLeft") and not has_relevant_bodies($Right):
				rotation-=drifting_steering_speed*delta
				drift_direction=Rotation.Negative
			if Input.is_action_pressed("SteerRight") and not has_relevant_bodies($Left):
				rotation+=drifting_steering_speed*delta
				drift_direction=Rotation.Positive
			
			if not texture_overriden:
				$Cat.texture=cat_drift
				$Cat.flip_h=drift_direction==Rotation.Positive

	if Input.is_action_pressed("break") and breaking_enabled:
		impulse-=break_force*delta

func revert_speed(mult):
	speed_multiplier/=mult

func impulse_texture_end():
	texture_overriden=false

func set_state(new_state:State):
	current_state=new_state

func has_relevant_bodies(area:Area2D):
	
	for i in area.get_overlapping_bodies():
		if i!=self:
			return true
	return false
