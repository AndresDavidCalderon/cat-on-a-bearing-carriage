extends Node

enum lossReason{
	IMPULSE_RAN_OUT
}

signal packet_delivered
signal loss(reason:lossReason)

var delivery_targets=[]

var current_target:Node=null
var packet_score:int=0

func _ready() -> void:
	randomize()

func register_target(target:Node):
	delivery_targets.append(target)


func _on_start_pressed() -> void:
	set_current_target(delivery_targets.pick_random())

func target_reached():
	set_current_target(delivery_targets.pick_random())
	packet_score+=1
	packet_delivered.emit()

func set_current_target(target:Node2D):
	if current_target!=null:
		current_target.hide()
	if target!=null:
		target.show()
	current_target=target

func lost(loss_reason):
	set_current_target(null)
	loss.emit(loss_reason)
