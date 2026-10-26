extends Node

var current_score: int = 0
var high_score: int = 0

const SAVE_PATH: String = "user://highscore.dat"

func _ready() -> void:
	load_score()

func add_score(amount: int = 1) -> void:
	current_score += amount

func submit_score() -> void:
	if current_score > high_score:
		high_score = current_score
		save_score()

func save_score() -> void:
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_32(high_score)

func load_score() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return
	high_score = file.get_32() 
