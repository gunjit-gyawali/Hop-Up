extends Label

var current_score = 0
var high_score = 0

const SAVE_PATH = "user://highscore.dat"

func _ready() -> void:
	load_score()

func save_score():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ_WRITE)
	file.store_32(high_score)
	
func load_score():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		high_score = file.get_32() 
