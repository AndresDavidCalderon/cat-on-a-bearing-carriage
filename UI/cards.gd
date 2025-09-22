extends Control

var rotation_step=PI/12
var position_step=80

func adjust_layout():
	for i in get_child_count():
		var child = get_child(i) as Control
		child.rotation=rotation_step*(i-ceil(get_child_count()/2))
		child.position.x=80*(i-ceil(get_child_count()/2))
