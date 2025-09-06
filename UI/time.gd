extends Control

@onready var match_provider=get_node("/root/World")

func _ready() -> void:
	hide()


func _on_world_match_state_changed(new_state: bool) -> void:
	if new_state==true:
		show()

func _process(delta: float) -> void:
	if match_provider.running:
		$Label.text=str(int(match_provider.remaining_time))
