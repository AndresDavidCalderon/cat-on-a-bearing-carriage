extends Node

var delivery_targets=[]

var current_target:Node=null

func _ready() -> void:
	randomize()

func register_target(target:Node):
	delivery_targets.append(target)


func _on_start_pressed() -> void:
	current_target=delivery_targets.pick_random()
