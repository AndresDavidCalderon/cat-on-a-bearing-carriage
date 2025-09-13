extends Node2D

signal delivered

func _ready() -> void:
	get_node("/root/World").register_target(self)
	hide()

func _on_area_body_entered(body: Node2D) -> void:
	if body==get_node("/root/World/Player"):
		if get_node("/root/World").current_target==self:
			get_node("/root/World").target_reached()
			$Person/CollisionShape2D.set_deferred("disabled",true)
			$Person/PotColission.set_deferred("disabled",true)

func enable():
	$Person/CollisionShape2D.set_deferred("disabled",false)
	$Person/PotColission.set_deferred("disabled",false)
