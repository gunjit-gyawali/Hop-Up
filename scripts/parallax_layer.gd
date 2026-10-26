extends Node2D

@export var camera: Camera2D

@onready var bg1: Sprite2D = $BG1
@onready var bg2: Sprite2D = $BG2

var tile_height: float = 0.0

func _ready() -> void:
	var view: Vector2 = get_viewport_rect().size
	var tex: Texture2D = bg1.texture
	if tex == null:
		return

	var s: float = view.x / float(tex.get_width())
	tile_height = float(tex.get_height()) * s

	for bg: Sprite2D in [bg1, bg2]:
		bg.centered = false
		bg.scale = Vector2(s, s)

	bg1.flip_v = false
	bg2.flip_v = true

	bg1.position = Vector2(0, -tile_height)
	bg2.position = Vector2(0, 0)

func _process(_delta: float) -> void:
	if camera == null or tile_height <= 0.0:
		return

	var view_bottom: float = camera.global_position.y + get_viewport_rect().size.y / 2.0

	for bg: Sprite2D in [bg1, bg2]:
		if bg.position.y > view_bottom:
			bg.position.y = minf(bg1.position.y, bg2.position.y) - tile_height
