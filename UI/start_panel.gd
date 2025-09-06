extends Panel

@onready var score_provider=get_node("/root/World")

func _ready() -> void:
	$DayTitle.text="Day "+score_provider.current_day


func _on_start_pressed() -> void:
	hide()
