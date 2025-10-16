extends AnimatableBody2D

enum State{
	APPROACHING_COW,
	MILKING,
	STORING_BOTTLE
}
@onready var defense_manager=get_node("/root/World/DefendTheMilk")

var current_state=State.APPROACHING_COW
var target_cow=null

func _process(delta: float) -> void:
	match current_state:
		State.APPROACHING_COW:
			if target_cow==null:
				target_cow=defense_manager.get_cow_assigned(self)
			
