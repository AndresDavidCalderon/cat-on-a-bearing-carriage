extends AnimatableBody2D

@onready var round_manager=get_node("/root/World")

var chosen_direction=Vector2.ZERO
var speed=5
var rotation_speed=1
var being_milked=false

func _ready() -> void:
	chosen_direction=Vector2.from_angle(randf_range(0,PI*2))

func _physics_process(delta: float) -> void:
	if round_manager.current_match_state!=round_manager.matchState.PLAYING:
		return
	if not being_milked:
		if chosen_direction!=Vector2.ZERO:
			move_and_collide(chosen_direction*speed*delta)
			rotation=rotate_toward(rotation,chosen_direction.angle(),rotation_speed*delta)

func _on_move_again_timeout() -> void:
	if chosen_direction!=Vector2.ZERO:
		chosen_direction=Vector2.ZERO
	else:
		chosen_direction=Vector2.from_angle(randf_range(0,PI*2))

func start_milking():
	being_milked=true

func end_milking():
	being_milked=false
