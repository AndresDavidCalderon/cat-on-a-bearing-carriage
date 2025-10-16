extends Node2D

@export var right_detection:Area2D
@export var left_detection:Area2D
@onready var match_provider=get_node("/root/World")
@onready var delivery_manager=match_provider.get_node("DeliveryMode")
@export var milk_textures:Array[Texture]
var bottles_scale=Vector2(0.4,0.4)
var avaliable_places=[]
var items=[]
var loaded_nodes=[]

func _ready() -> void:
	match_provider.match_state_changed.connect(match_change)
	if GlobalScore.current_mode==GlobalScore.gameModes.DELIVERY:
		delivery_manager.packet_delivered.connect(on_delivery)
	$Skins.hide()
	load_skin(GlobalScore.current_skin)
	GlobalScore.equiped_cosmetic_changed.connect(on_equiped_cosmetic_changed)

func on_equiped_cosmetic_changed():
	load_skin(GlobalScore.current_skin)

func load_node(node_path:String,insert_in:Node,reference:Node):
	var node=reference.get_node(node_path)
	var imported=node.duplicate()
	insert_in.add_child.call_deferred(imported)
	loaded_nodes.append(imported)

func load_skin(skin:CarSkin):
	var reference=get_node("Skins/"+skin.reference_node_name)
	for i in loaded_nodes:
		i.queue_free()
	loaded_nodes=[]
	load_node("MilkPlaces",self,reference)
	load_node("CarSprite",self,reference)
	load_node("LeftDetectionShape",left_detection,reference)
	load_node("RightDetectionShape",right_detection,reference)
	load_node("MainColissionShape",get_parent(),reference)

func match_change(state:int):
	if state==match_provider.matchState.PLAYING:
		setup_bottles(delivery_manager.packet_target)

func on_delivery():
	if items.is_empty() or delivery_manager.packet_target-delivery_manager.packet_score>=10:
		return
	var item=items.pick_random()
	avaliable_places.append(item.get_parent())
	items.erase(item)
	item.queue_free()

func setup_bottles(amount:int):
	for i in range(amount):
		if avaliable_places.is_empty():
			break
		var sprite = Sprite2D.new()
		var child_texture=milk_textures.pick_random()
		sprite.texture=child_texture
		sprite.scale=bottles_scale
		var place = avaliable_places.pick_random()
		place.add_child(sprite)
		avaliable_places.erase(place)
		items.append(sprite)
