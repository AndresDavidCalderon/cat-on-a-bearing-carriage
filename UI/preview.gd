extends Control

var current_preview:CarSkin

func _ready() -> void:
	hide()
	for i in get_parent().get_node("GridContainer").get_children():
		i.pressed.connect(preview.bind(i.skin))

func preview(skin:CarSkin):
	show()
	$Title.text=skin.display_name
	if skin.descriptions.length()>100:
		$Description.add_theme_font_size_override("font_size",12)
	else:
		$Description.add_theme_font_size_override("font_size",18)
	$Description.text=skin.descriptions
	$Icon.texture=skin.icon
	if GlobalScore.owned_skins.has(skin.reference_node_name):
		$Owned.show()
		$Cost.hide()
		if GlobalScore.current_skin==skin:
			$Buy.text="Equiped!"
			$Buy.disabled=true
		else:
			$Buy.text="Equip"
			$Buy.disabled=false
	else:
		$Cost.show()
		$Owned.hide()
		$Cost/Label.text=str(skin.cost)
		$Buy.text="Buy"
		$Buy.disabled=GlobalScore.coins<skin.cost
	current_preview=skin

func _on_buy_pressed() -> void:
	if GlobalScore.owned_skins.has(current_preview.reference_node_name):
		GlobalScore.set_equiped_car_skin(current_preview)
	else:
		GlobalScore.set_coins(GlobalScore.coins-current_preview.cost)
		GlobalScore.owned_skins.append(current_preview.reference_node_name)
		GlobalScore.set_equiped_car_skin(current_preview)
		GlobalScore.owned_cosmetics_updated.emit()
	
	preview(current_preview)
