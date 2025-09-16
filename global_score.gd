extends Node

signal coins_changed

var current_day=1
var coins:int=0

func set_coins(amount:int):
	coins=amount
	coins_changed.emit()
