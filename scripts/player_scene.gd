extends CharacterBody2D

@export var MAX_SPEED: float = 600.0
@export var ACCELERATION: float = 6000.0
@export var DECELERATION: float = 6000.0

@onready var PLAYER_ANIMATION_TREE: AnimationTree = $Character/CharacterAnimationTree
@onready var PLAYER_ANIMATION_STATE: AnimationNodeStateMachinePlayback = PLAYER_ANIMATION_TREE.get("parameters/playback")

#enum DIRECTION {UP, DOWN, LEFT, RIGHT}

func _ready():
	pass

func _process(delta: float):
	pass

func _physics_process(delta: float):
	# Get the input direction and handle the movement/deceleration.
	handle_movement(delta)
	

func handle_movement(delta: float) -> bool:
	var direction: Vector2 = get_direction()
	
	if direction:
		PLAYER_ANIMATION_TREE.set("parameters/idle/blend_position", direction)
		PLAYER_ANIMATION_TREE.set("parameters/run/blend_position", direction)
		PLAYER_ANIMATION_STATE.travel("run")
		velocity = velocity.move_toward(direction*MAX_SPEED, ACCELERATION*delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
		PLAYER_ANIMATION_STATE.travel("idle")
	
	return move_and_slide()

func get_direction() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("play_left", "play_right")
	direction.y = Input.get_axis("play_up", "play_down")
	return direction.normalized()



