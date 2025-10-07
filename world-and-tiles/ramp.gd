extends Line2D

@onready var player=get_node("/root/World/Player")

var affecting=false
var down_force=100
var impulse_deduction=1


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body==player:
		affecting=true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body==player:
		affecting=false

func _process(delta: float) -> void:
	if affecting:
		var direction=points[1].direction_to(points[0])
		player.external_forces[get_path()]=direction*down_force
		var direction_affinity=(player.velocity as Vector2).normalized().dot(direction.rotated(PI/2).normalized())
		player.impulse+=impulse_deduction*direction_affinity*delta
		$Affinity.text=str(direction_affinity)
	else:
		if player.external_forces.has(get_path()):
			player.external_forces.erase(get_path())
