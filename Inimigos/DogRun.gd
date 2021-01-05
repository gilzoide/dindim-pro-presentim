extends KinematicBody2D

export(float) var speed = 300
export(float) var damage = 20
export(float) var change_time = 1

onready var sprite : AnimatedSprite = $AnimatedSprite
var direction = Vector2.UP
var timer = 0

func _ready():
	set_physics_process(true)
	sprite.play()

func _physics_process(delta):
	timer += delta
	if timer >= change_time:
		timer = 0
		direction = Vector2.UP.rotated(randf() * 2 * PI)
		sprite.flip_h = direction.x < 0
	var _collision = move_and_collide(direction * speed * delta)
