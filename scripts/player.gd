extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_speed: float = 600.0
@export var gravity: float = 1200.0

var screen_width: float = 0.0

func _ready() -> void:
	screen_width = get_viewport_rect().size.x

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction: float = Input.get_axis("left", "right")
	velocity.x = direction * speed

	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction > 0:
		$AnimatedSprite2D.flip_h = false

	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision: KinematicCollision2D = get_slide_collision(i)
		var collider: Object = collision.get_collider()
		if collider is Node and (collider as Node).is_in_group("platform"):
			if collision.get_normal().y < -0.7 and velocity.y >= 0:
				velocity.y = -jump_speed

	_wrap_horizontal()

func _wrap_horizontal() -> void:
	if global_position.x < 0.0:
		global_position.x = screen_width
	elif global_position.x > screen_width:
		global_position.x = 0.0
