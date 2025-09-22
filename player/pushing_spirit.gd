extends Node2D

@onready var blessing_provider=get_node("/root/World/Blessings")

func _on_player_drift_started() -> void:
	if blessing_provider.stop_drift:
		$StartPush.play("grab")
		print("Playin")


func _on_player_drift_ended() -> void:
	$StartPush.stop()
	var tween=create_tween()
	tween.tween_property($Sprite,"modulate:a",0,0.3)
