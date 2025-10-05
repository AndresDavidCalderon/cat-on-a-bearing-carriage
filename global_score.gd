extends Node

signal coins_changed
signal owned_cosmetics_updated
signal equiped_cosmetic_changed

var current_day=1
var coins:int=0
var mechanic_intro_shown=false
var mechanic_day=3
var owned_skins=[
	"Default"
]
var current_skin:CarSkin=preload("res://player/skins/default.tres")

func set_coins(amount:int):
	coins=amount
	coins_changed.emit()

func set_equiped_car_skin(skin:CarSkin):
	current_skin=skin
	equiped_cosmetic_changed.emit()
