extends KinematicBody2D

export var linearVelocity: float = 100
var direction = Vector2.ZERO

onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
	else:
		direction.y = 0
	
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1
	else:
		direction.x = 0
	if direction.x != 0 or direction.y != 0:
		direction = direction.normalized()
		animationPlayer.play("PlayerAnimation")
	move_and_slide(direction * linearVelocity)
