extends Sprite2D


@export var cat_drift:Texture
@export var cat_push:Texture
@export var cat_default:Texture

@onready var player=get_parent()

var cat_push_time=1.2

func _on_player_drift_started() -> void:
	set_drifting_sprite()


func _on_player_drift_ended() -> void:
	texture=cat_default


func _on_player_impulsed() -> void:
	texture=cat_push
	await get_tree().create_timer(cat_push_time).timeout
	match get_parent().current_state:
		player.State.SLIDING:
			texture=cat_default
		player.State.DRIFTING:
			set_drifting_sprite()

func set_drifting_sprite():
	texture=cat_drift
	flip_h=player.drift_direction==player.Rotation.POSITIVE


func _on_player_drift_direction_changed() -> void:
	set_drifting_sprite()
