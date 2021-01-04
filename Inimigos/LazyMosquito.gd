extends KinematicBody2D

export(Vector2) var direction: Vector2 = Vector2(1, 1)
export(float) var speed = 200
export(float) var damage = 10
onready var sprite: AnimatedSprite = $AnimatedSprite

func _ready():
	set_physics_process(true)
	sprite.play()

func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		direction = direction.bounce(collision.normal)
		sprite.flip_h = direction.x < 0
