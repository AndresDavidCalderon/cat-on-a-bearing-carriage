extends Area2D

signal interacted

@onready var player = get_node("/root/World/Player")

func _ready() -> void:
	$Label.hide()
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and get_overlapping_bodies().has(player):
		interacted.emit()

func on_body_entered(body):
	if body==player:
		$Label.show()

func on_body_exited(body):
	if body==player:
		$Label.hide()
