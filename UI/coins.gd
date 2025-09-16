extends Control

func _ready() -> void:
	update()
	GlobalScore.coins_changed.connect(update)

func update():
	$Label.text="Coins: "+str(GlobalScore.coins)
