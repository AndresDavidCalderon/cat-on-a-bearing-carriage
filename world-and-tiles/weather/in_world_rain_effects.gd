extends Node

@export var droplet:PackedScene
@export var ray:PackedScene
@export var roof_material:ShaderMaterial

@onready var player:Node2D=get_node("/root/World/Player")

## Half of the width of the relevant area.
## in other words, the horizontal distance between the player
## and effects.
var relevant_width:float=1200

## Half of the height of the relevant_area
var relevant_height:float=800
var modulate_multiplier:float=0

func _ready() -> void:
	if Weather.get_weather_today()==Weather.Weather.RAINY:
		$NewDroplet.start()
		$NewRay.start()
		for i in get_tree().get_nodes_in_group("shadows"):
			i.modulate.a*=modulate_multiplier
	roof_material.set_shader_parameter("raining",Weather.get_weather_today()==Weather.Weather.RAINY)

func get_relevant_random_point():
	var offset_y=randf_range(-relevant_height,relevant_height)
	var offset_x=randf_range(-relevant_width,relevant_width)
	return player.global_position+Vector2(offset_x,offset_y)

func _on_new_droplet_timeout() -> void:
	var instance=droplet.instantiate()
	random_spawn(instance)

func random_spawn(thing:Node2D):
	var pos=get_relevant_random_point()
	add_child(thing)
	thing.global_position=pos


func _on_new_ray_timeout() -> void:
	var instance=ray.instantiate()
	random_spawn(instance)
