extends Button

@export var skin:CarSkin

func _ready() -> void:
	$TextureRect.texture=skin.icon
	$Name.text=skin.display_name
	$Cost/Cost.text=skin.cost
	
