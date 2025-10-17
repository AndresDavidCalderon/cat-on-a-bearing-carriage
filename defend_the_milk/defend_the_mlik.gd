extends Node


@onready var player=get_node("/root/World/Player")
## Aside of not including assigned cows, does not include
## cows that were succesfully milked. Which might not be the same
## If you don't stop someone milking your cow midway.
@onready var avaliable_cows=$Cows.get_children()

var lost_bottles=0

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

func bottle_lost():
	lost_bottles+=1
	if lost_bottles>=$Cows.get_child_count():
		get_parent().loss.emit(get_parent().lossReason.COWS_MILKED)
		get_parent().set_match_state(get_parent().matchState.LOST)


func _on_spawn_timeout() -> void:
	if avaliable_cows.size()>0:
		$DeliveryTrucks.get_children().pick_random().spawn()


func _on_world_match_started() -> void:
	if is_mode():
		$Spawn.start()

func get_total_bottles():
	return $Cows.get_child_count()

func get_remaining_bottles():
	return get_total_bottles()-lost_bottles

func _on_world_time_ran_out() -> void:
	get_parent().set_match_state(get_parent().matchState.WON)
	get_parent().win.emit()


func _on_world_match_state_changed(new_state: int) -> void:
	if new_state!=get_parent().matchState.PLAYING:
		process_mode=Node.PROCESS_MODE_DISABLED
