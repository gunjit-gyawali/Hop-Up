
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		HighScoreNum.submit_score()
		get_tree().call_deferred("change_scene_to_file", "res://scenes/lost.tscn")
