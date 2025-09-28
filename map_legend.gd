extends Sprite2D

@onready var ui:CanvasLayer=get_node("/root/World/UI")

func _process(_delta: float) -> void:
	var camera:Camera2D=ui.map_camera
	var viewport=ui.map_viewport
	var size=viewport.get_visible_rect().size/camera.zoom
	var view=Rect2(camera.get_target_position()-size/2,size)
	if view.has_point(get_parent().global_position):
		position=Vector2.ZERO
	else:
		var sides=[
			[view.position,view.position+Vector2(0,view.size.y)],
			[view.position,view.position+Vector2(view.size.x,0)],
			[view.position+Vector2(0,view.size.y),view.end],
			[view.position+Vector2(view.size.x,0),view.end]
		]
		var closest_distance=0
		var closest_point
		var closest_idx
		for i in range(sides.size()):
			var point=Geometry2D.get_closest_point_to_segment(get_parent().global_position,sides[i][0],sides[i][1])
			var distance=point.distance_to(get_parent().global_position)
			if distance<closest_distance or closest_point==null:
				closest_distance=distance
				closest_point=point
				closest_idx=i
		var distance_multiplier=1
		if ui.get_node("%Minimap").visible:
			distance_multiplier*=0.9
		global_position=camera.get_target_position()+(closest_point-camera.get_target_position())*distance_multiplier
