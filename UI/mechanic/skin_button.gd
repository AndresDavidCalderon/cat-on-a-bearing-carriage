extends Button

@export var skin:CarSkin

func _ready() -> void:
	$TextureRect.texture=skin.icon
	$Name.text=skin.display_name
	$Cost/Cost.text=str(skin.cost)
	update()
	GlobalScore.owned_cosmetics_updated.connect(update)


func update():
	if GlobalScore.owned_skins.has(skin.reference_node_name):
		$Owned.show()
		$Cost.hide()
