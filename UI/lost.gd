extends Control

@onready var try_provider=get_node("/root/World")

func _on_world_loss(reason) -> void:
	show()
	if reason==try_provider.lossReason.IMPULSE_RAN_OUT:
		$Panel/Description.text="""You ran out of impulse! try to catch a booster more often."""


func _on_repeat_pressed() -> void:
	get_tree().reload_current_scene()
