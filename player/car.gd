extends Sprite2D

@onready var match_provider=get_node("/root/World")
@export var milk_textures:Array[Texture]
var bottles_scale=Vector2(0.4,0.4)
var avaliable_places=[]
var items=[]

func _ready() -> void:
	match_provider.match_state_changed.connect(match_change)
	match_provider.packet_delivered.connect(on_delivery)
	avaliable_places=get_children()

func match_change(state:bool):
	if state:
		setup_bottles(match_provider.packet_target)

func on_delivery():
	if items.is_empty() or match_provider.packet_target-match_provider.packet_score>=10:
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
