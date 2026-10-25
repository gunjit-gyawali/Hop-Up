
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if HighScoreNum.current_score > HighScoreNum.high_score:
			HighScoreNum.high_score = HighScoreNum.current_score

		get_tree().change_scene_to_file.call_deferred(
            "res://scenes/lost.tscn"
		)
