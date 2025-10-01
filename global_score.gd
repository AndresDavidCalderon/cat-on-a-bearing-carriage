extends Node

signal coins_changed

var current_day=1
var coins:int=0
var mechanic_intro_shown=false
var mechanic_day=3

func set_coins(amount:int):
	coins=amount
	coins_changed.emit()
