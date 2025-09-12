extends Sprite2D

@onready var viewport:SubViewport=get_node("/root/World").minimap_viewport

func _ready() -> void:
	get_node("/root/World").ready.connect(set_viewport)

func set_viewport():
	viewport=get_node("/root/World").minimap_viewport

func _process(delta: float) -> void:
	var camera:Camera2D=viewport.get_node("Camera2D")
	var size=viewport.get_visible_rect().size/camera.zoom
	var view=Rect2(camera.get_target_position()-size/2,size)
	if view.has_point(get_parent().global_position):
		position=Vector2.ZERO
	else:
		var direction=camera.get_target_position()-get_parent().global_position
		global_position=camera.get_target_position()-direction.normalized()*500
		
