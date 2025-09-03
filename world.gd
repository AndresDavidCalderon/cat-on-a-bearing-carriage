extends Node

var delivery_targets=[]

var current_target:Node=null

func register_target(target:Node):
	delivery_targets.append(target)
