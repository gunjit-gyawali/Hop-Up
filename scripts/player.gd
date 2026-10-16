extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_speed: float = 600.0
@export var gravity: float = 1200.0

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Left and right movement
	var direction: float = Input.get_axis("left", "right")
	velocity.x = direction * speed

	# Flip animated sprite
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction > 0:
		$AnimatedSprite2D.flip_h = false

	# Move and detect collisions
	move_and_slide()

	# Bounce on platform when landing from above
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider.is_in_group("platform"):
			if collision.get_normal().y < -0.7 and velocity.y >= 0:
				velocity.y = -jump_speed
