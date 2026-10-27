extends Control

func _ready() -> void:
	$high_score_num.text = str(HighScoreNum.high_score)

func _on_button_pressed() -> void:
	$pressed.play()
	await $pressed.finished
	HighScoreNum.current_score = 0
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	BgMusic.stop()

func _on_button_2_pressed() -> void:
	$pressed.play()
	await $pressed.finished
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
	
func _on_button_3_pressed() -> void:
	$pressed.play()
	await $pressed.finished
	get_tree().quit()

func _on_button_mouse_entered() -> void:
	$hover.play()


func _on_button_2_mouse_entered() -> void:
	$hover.play()


func _on_button_3_mouse_entered() -> void:
	$hover.play()
