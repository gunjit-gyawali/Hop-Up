extends Control

var audio_on = true

func _on_button_pressed() -> void:
	$pressed.play()
	await $pressed.finished
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_button_2_pressed() -> void:
	$pressed.play()
	await $pressed.finished
	if audio_on == true:
		BgMusic.stop()
		$Label3.text = "OFF"
		audio_on = false
	else:
		BgMusic.play()
		$Label3.text = "ON"
		audio_on = true
	
func _on_button_3_pressed() -> void:
	$pressed.play()
	await $pressed.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_button_mouse_entered() -> void:
	$hover.play()


func _on_button_2_mouse_entered() -> void:
	$hover.play()


func _on_button_3_mouse_entered() -> void:
	$hover.play()
