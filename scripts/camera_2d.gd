extends Camera2D

@export var player: Node2D
@export var follow_height: float = 100.0

var highest_y: float

func _ready() -> void:
	highest_y = global_position.y

func _process(_delta: float) -> void:
	if player == null:
		return

	# Move camera upward only when player rises above the target height
	var target_y: float = player.global_position.y + follow_height

	if target_y < highest_y:
		highest_y = target_y

	global_position.y = highest_y
