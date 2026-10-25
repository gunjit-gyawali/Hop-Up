extends Control

func _ready() -> void:
	$high_score_num.text = str(HighScoreNum.high_score)

func _on_button_pressed() -> void:
	$pressed.play()
	await $pressed.finished
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	
func _on_button_3_pressed() -> void:
	$pressed.play()
	await $pressed.finished
	get_tree().quit()

func _on_button_mouse_entered() -> void:
	$hover.play()


func _on_button_3_mouse_entered() -> void:
	$hover.play()
