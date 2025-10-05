extends Control

var current_preview:CarSkin

func _ready() -> void:
	hide()
	for i in get_parent().get_node("GridContainer"):
		i.pressed.connect(preview.bind(i.skin))

func preview(skin:CarSkin):
	show()
	$Title.text=skin.display_name
	$Icon.texture=skin.icon
	if GlobalScore.owned_skins.has(skin.reference_node_name):
		$Owned.show()
		$Cost.hide()
		$Buy.text="Equip"
	else:
		$Cost.show()
		$Owned.hide()
		$Cost/Label.text=str(skin.cost)
		$Buy.text="Buy"
	current_preview=skin

func _on_buy_pressed() -> void:
	if GlobalScore.owned_skins.has(current_preview.reference_node_name):
		GlobalScore.set_equiped_car_skin(current_preview)
	else:
		GlobalScore.owned_skins.append(current_preview.reference_node_name)
		GlobalScore.owned_cosmetics_updated.emit()
	
	preview(current_preview)
