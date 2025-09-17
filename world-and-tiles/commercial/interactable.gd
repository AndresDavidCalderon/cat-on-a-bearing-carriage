extends Area2D

signal interacted

@onready var player = get_node("/root/World/Player")
@onready var match_provider = get_node("/root/World")

func _ready() -> void:
	$Label.hide()
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("interact") and get_overlapping_bodies().has(player) and 
		match_provider.current_match_state==match_provider.matchState.PLAYING):
		interacted.emit()

func on_body_entered(body):
	if body==player and match_provider.current_match_state==match_provider.matchState.PLAYING:
		$Label.show()

func on_body_exited(body):
	if body==player:
		$Label.hide()
