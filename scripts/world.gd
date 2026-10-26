
extends Node2D

@export var platform_scene: PackedScene
@export var pickup_scene: PackedScene
@export var player: Node2D

@export var platform_count: int = 5
@export var vertical_spacing_min: float = 100.0
@export var vertical_spacing_max: float = 155.0
@export var max_horizontal_distance: float = 130.0
@export var horizontal_margin: float = 70.0
@export var spawn_ahead_distance: float = 1750.0
@export var despawn_distance: float = 900.0
@export var pickup_chance: float = 0.4

var screen_width: float = 0.0
var last_platform_y: float = 0.0
var last_platform_x: float = 0.0


func _ready() -> void:
	$player/Camera2D/high_score_num.text = str(HighScoreNum.high_score)
	randomize()
	screen_width = get_viewport_rect().size.x

	last_platform_x = screen_width / 2.0

	if player != null:
		last_platform_x = clampf(player.global_position.x, horizontal_margin, screen_width - horizontal_margin)

	_spawn_start_platform()

	for i in range(platform_count):
		spawn_platform()


func _spawn_start_platform() -> void:
	if platform_scene == null:
		return

	var platform: Node2D = platform_scene.instantiate()
	add_child(platform)

	var start_y: float = 0.0
	if player != null:
		start_y = player.global_position.y + 100.0

	platform.position = Vector2(last_platform_x, start_y)
	last_platform_y = start_y

	if pickup_scene != null:
		_spawn_pickup(Vector2(last_platform_x, start_y - 42.0))


func spawn_platform() -> void:
	if platform_scene == null:
		return

	var platform: Node2D = platform_scene.instantiate()
	add_child(platform)

	var min_x: float = maxf(horizontal_margin, last_platform_x - max_horizontal_distance)
	var max_x: float = minf(screen_width - horizontal_margin, last_platform_x + max_horizontal_distance)
	var x: float = randf_range(min_x, max_x)

	var spacing: float = randf_range(vertical_spacing_min, vertical_spacing_max)
	last_platform_y -= spacing

	platform.position = Vector2(x, last_platform_y)
	last_platform_x = x

	if pickup_scene != null and randf() < pickup_chance:
		_spawn_pickup(Vector2(x, last_platform_y - 42.0))


func _spawn_pickup(pos: Vector2) -> void:
	var pickup: Node2D = pickup_scene.instantiate()
	add_child(pickup)
	pickup.position = pos
	pickup.add_to_group("pickup")


func _process(_delta: float) -> void:
	if player == null:
		return

	var score_label: Label = get_node_or_null("player/Camera2D/score_counter")
	if score_label != null:
		score_label.text = str(HighScoreNum.current_score)

	var player_y: float = player.global_position.y

	while last_platform_y > player_y - spawn_ahead_distance:
		spawn_platform()

	_cull(player_y + despawn_distance)


func _cull(limit_y: float) -> void:
	for node: Node in get_children():
		if node is not Node2D:
			continue
		if node.is_in_group("platform") or node.is_in_group("pickup"):
			if (node as Node2D).position.y > limit_y:
				node.queue_free()
