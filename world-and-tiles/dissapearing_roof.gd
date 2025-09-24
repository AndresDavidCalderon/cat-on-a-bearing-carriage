extends CanvasItem

@onready var player = get_node("/root/World/Player")

@export var interior_opacity=0.1
@export var default_opacity=0.8
var current_tween:Tween
@export var change_modulate_of:CanvasItem=self

func _ready() -> void:
	show()
	$Area2D.body_entered.connect(_on_area_2d_body_entered)
	$Area2D.body_exited.connect(_on_area_2d_body_exited)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body==player:
		current_tween=create_tween()
		current_tween.tween_property(change_modulate_of,"modulate:a",interior_opacity,0.3)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body==player:
		current_tween=create_tween()
		current_tween.tween_property(change_modulate_of,"modulate:a",default_opacity,0.3)
