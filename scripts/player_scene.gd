extends CharacterBody2D

@export var SPEED: float = 300.0

func _process(delta: float):
	return

func _physics_process(delta: float):
	# Get the input direction and handle the movement/deceleration.
	handle_movement(delta)
	

func handle_movement(delta: float) -> KinematicCollision2D:
	var velocity: Vector2 = get_direction()
	return move_and_collide(velocity * delta)

func get_direction() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("play_left", "play_right")
	direction.y = Input.get_axis("play_up", "play_down")
	print(direction.normalized() * SPEED)
	return direction.normalized() * SPEED
