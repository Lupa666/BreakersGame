extends CharacterBody2D

@export var MAX_SPEED: float = 600.0
@export var ACCELERATION: float = 5000
@export var DECELERATION: float = 5000

@onready var PLAYER_SPRITE = $PlayerSprite2D

func _process(delta: float):
	print(velocity)
	
	if velocity.x > 0:
		PLAYER_SPRITE.flip_h = false
	else:
		PLAYER_SPRITE.flip_h = true
	return

func _physics_process(delta: float):
	# Get the input direction and handle the movement/deceleration.
	handle_movement(delta)
	

func handle_movement(delta: float) -> KinematicCollision2D:
	var direction: Vector2 = get_direction()
	
	if direction:
		velocity = velocity.move_toward(direction*MAX_SPEED, ACCELERATION*delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
	
	return move_and_collide(velocity * delta)

func get_direction() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("play_left", "play_right")
	direction.y = Input.get_axis("play_up", "play_down")
	return direction.normalized()
