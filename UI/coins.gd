extends Control

func _ready() -> void:
	update()
	GlobalScore.coins_changed.connect(update)

func update():
	$Label.text=str(GlobalScore.coins)
