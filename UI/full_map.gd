extends Control

@onready var match_provider=get_node("/root/World")

func _ready() -> void:
	hide()
	match_provider.match_state_changed.connect(on_match_state_change)

func on_match_state_change(new_state:int):
	if new_state!=match_provider.matchState.PLAYING:
		disable()

func _input(event: InputEvent) -> void:
	if match_provider.current_match_state!=match_provider.matchState.PLAYING:
		return
	
	if event.is_action_pressed("toggleMap"):
		if visible:
			disable()
		else:
			show()
			get_parent().map_camera=$FullMap/FullSubViewport/FullMapCamera
			get_parent().map_viewport=$FullMap/FullSubViewport
			%Minimap.hide()

func disable():
	hide()
	get_parent().map_camera=%MiniMapCamera
	get_parent().map_viewport=%MiniSubViewport
	%MiniMapContainer.show()
	
