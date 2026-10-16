
extends Node2D

@export var platform_scene: PackedScene
@export var player: Node2D

@export var platform_count: int = 20

# Vertical spacing: a little more space
@export var vertical_spacing_min: float = 45.0
@export var vertical_spacing_max: float = 75.0

# Horizontal randomness
@export var max_horizontal_distance: float = 180.0
@export var horizontal_margin: float = 50.0

# Spawn platforms above the player
@export var spawn_ahead_distance: float = 1500.0

var screen_width: float
var last_platform_y: float = 0.0
var last_platform_x: float = 0.0


func _ready() -> void:
	randomize()
	screen_width = get_viewport_rect().size.x

	last_platform_x = screen_width / 2.0

	for i in range(platform_count):
		spawn_platform()


func spawn_platform() -> void:
	if platform_scene == null:
		return

	var platform = platform_scene.instantiate()
	add_child(platform)

	# Random horizontal position near the previous platform
	var min_x = max(
		horizontal_margin,
		last_platform_x - max_horizontal_distance
	)

	var max_x = min(
		screen_width - horizontal_margin,
		last_platform_x + max_horizontal_distance
	)

	var x = randf_range(min_x, max_x)

	# Random vertical gap
	var spacing = randf_range(
		vertical_spacing_min,
		vertical_spacing_max
	)

	last_platform_y -= spacing

	platform.position = Vector2(x, last_platform_y)

	last_platform_x = x


func _process(_delta: float) -> void:
	if player == null:
		return

	var player_y = player.global_position.y

	while last_platform_y > player_y - spawn_ahead_distance:
		spawn_platform()
