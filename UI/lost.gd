extends Control

@onready var try_provider=get_node("/root/World")

func _ready() -> void:
	try_provider.loss.connect(_on_world_loss)

func _on_world_loss(reason) -> void:
	show()
	if reason==try_provider.lossReason.TIME_OUT:
		$Panel/Description.text="""You ran out of time!"""
		if randf()>0.5:
			$Panel/Description.text+="\n Now you'll have to drink it all yourself"


func _on_repeat_pressed() -> void:
	get_tree().reload_current_scene()
