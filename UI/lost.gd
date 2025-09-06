extends Control

@onready var try_provider=get_node("/root/World")

func _on_world_loss(reason) -> void:
	show()
	if reason==try_provider.lossReason.TIME_OUT:
		$Panel/Description.text="""You ran out of time! Drifting can help a great deal when making sharp turns,
		and that helps with not having to turn around later."""


func _on_repeat_pressed() -> void:
	get_tree().reload_current_scene()
