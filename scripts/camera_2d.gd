extends Camera2D

@export var player: Node2D
@export var follow_height: float = 100.0

var highest_y: float = 0.0
var fixed_x: float = 0.0

func _ready() -> void:
	highest_y = global_position.y
	fixed_x = get_viewport_rect().size.x / 2.0

func _process(_delta: float) -> void:
	if player == null:
		return

	var target_y: float = player.global_position.y + follow_height

	if target_y < highest_y:
		highest_y = target_y

	global_position = Vector2(fixed_x, highest_y)
