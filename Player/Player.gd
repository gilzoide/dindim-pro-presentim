extends KinematicBody2D

const INIMIGO_LAYER_BIT = 2

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
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.get_collision_layer_bit(INIMIGO_LAYER_BIT):
			print_debug("TROMBOU")
			break
