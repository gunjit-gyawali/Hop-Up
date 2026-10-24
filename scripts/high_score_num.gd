extends Label

const SAVE_PATH = "user://highscore.dat"

func _ready():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var score = file.get_float()
		text = score
	else:
		text = "0"
