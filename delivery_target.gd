extends Node2D

@onready var delivery_mode=get_node("/root/World/DeliveryMode")

signal delivered
var collisions=false

func _ready() -> void:
	if GlobalScore.current_mode==GlobalScore.gameModes.DELIVERY:
		delivery_mode.register_target(self)
	hide()

func _on_area_body_entered(body: Node2D) -> void:
	if GlobalScore.current_mode!=GlobalScore.gameModes.DELIVERY:
		return
	if body==get_node("/root/World/Player"):
		if delivery_mode.current_target==self:
			delivery_mode.target_reached()
			$Person/CollisionShape2D.set_deferred("disabled",true)
			$Person/PotColission.set_deferred("disabled",true)
			delivered.emit()

func enable():
	if collisions:
		$Person/CollisionShape2D.set_deferred("disabled",false)
		$Person/PotColission.set_deferred("disabled",false)
