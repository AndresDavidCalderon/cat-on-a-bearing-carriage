extends StaticBody2D

@export var burglar_template:PackedScene
@onready var burglar_path=get_node("/root/World/DefendTheMilk/Burglars")

func spawn():
	var new_burglar=burglar_template.instantiate()
	burglar_path.add_child(new_burglar)
	new_burglar.global_position=$SpawnPoint.global_position
