extends Node


@onready var player=get_node("/root/World/Player")

## Aside of not including assigned cows, does not include
## cows that were succesfully milk
@onready var avaliable_cows=$Cows.get_children()

var max_time=90
var assigned_cows={}

func _ready() -> void:
	if is_mode():
		player.global_position=$NightSpawnLocation.global_position
		get_parent().remaining_time=max_time
		get_parent().round_stats_set.emit()

func is_mode():
	return GlobalScore.current_mode==GlobalScore.gameModes.DEFEND

func get_cow_assigned(to):
	if avaliable_cows.size()>0:
		var cow = avaliable_cows.pick_random()
		avaliable_cows.erase(cow)
		assigned_cows[to.name]=cow
		return cow
	else:
		return null


func _on_spawn_timeout() -> void:
	$DeliveryTrucks.get_children().pick_random().spawn()
