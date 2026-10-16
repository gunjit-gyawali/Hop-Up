extends Node2D

@export var player: Node2D

@onready var bg1: Sprite2D = $BG1
@onready var bg2: Sprite2D = $BG2

var bg_height: float


func _ready():
	bg_height = bg1.texture.get_height() * abs(bg1.global_scale.y)

	# Place BG2 directly above BG1
	bg2.global_position.y = bg1.global_position.y - bg_height


func _process(_delta):
	if player == null:
		return

	# Reuse BG1 when the player passes its top edge
	if player.global_position.y < bg1.global_position.y - bg_height / 2.0:
		bg1.global_position.y = bg2.global_position.y - bg_height

	# Reuse BG2 when the player passes its top edge
	if player.global_position.y < bg2.global_position.y - bg_height / 2.0:
		bg2.global_position.y = bg1.global_position.y - bg_height
