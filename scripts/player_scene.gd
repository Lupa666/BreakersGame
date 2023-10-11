extends CharacterBody2D

enum state {FREE, ATTACK, DIE}

@export var MAX_SPEED: float = 400.0
@export var ACCELERATION: float = 6000.0

@onready var PLAYER_ANIMATION_TREE: AnimationTree = $Character/CharacterAnimationTree
@onready var PLAYER_ANIMATION_STATE: AnimationNodeStateMachinePlayback = PLAYER_ANIMATION_TREE.get("parameters/playback")
@onready var CURRENT_STATE: state = state.FREE


func _ready():
	CURRENT_STATE = state.FREE
	pass

func _process(delta: float):
	pass

func _physics_process(delta: float):
	# Get the input direction and handle the movement/deceleration.
	handle_movement(delta)
	move_and_slide()

func handle_movement(delta: float) -> void:
	var direction: Vector2 = get_direction()
	
	if direction != Vector2.ZERO:
		PLAYER_ANIMATION_TREE.set("parameters/idle/blend_position", direction)
		PLAYER_ANIMATION_TREE.set("parameters/run/blend_position", direction)
		PLAYER_ANIMATION_STATE.travel("run")
		velocity = velocity.move_toward(direction*MAX_SPEED, ACCELERATION * delta)
	if direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
		PLAYER_ANIMATION_STATE.travel("idle")
	if Input.is_action_just_pressed("attack"):
		PLAYER_ANIMATION_TREE.set("parameters/attack/blend_position", direction)
		PLAYER_ANIMATION_STATE.travel("attack")
	pass

func get_direction() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("play_left", "play_right")
	direction.y = Input.get_axis("play_up", "play_down")
	return direction.normalized()



