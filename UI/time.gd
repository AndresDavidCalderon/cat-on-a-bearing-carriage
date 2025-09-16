extends Control

@onready var match_provider=get_node("/root/World")

func _ready() -> void:
	match_provider.match_state_changed.connect(_on_world_match_state_changed)
	hide()


func _on_world_match_state_changed(new_state:int) -> void:
	if new_state==match_provider.matchState.PLAYING:
		show()

func _process(delta: float) -> void:
	match match_provider.current_match_state:
		match_provider.matchState.PLAYING:
			$Label.text=str(int(match_provider.remaining_time))
