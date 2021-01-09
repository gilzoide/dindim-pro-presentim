extends KinematicBody2D

export(float) var speed = 300
export(float) var damage = 50
export(float) var change_time = 1

onready var sprite : AnimatedSprite = $AnimatedSprite
var direction = Vector2.UP
onready var timer = change_time

func _ready():
    set_physics_process(true)
    sprite.play()

func _physics_process(delta):
    timer += delta
    if timer >= change_time:
        timer = 0
        direction = Vector2.UP.rotated(randf() * 2 * PI)
        sprite.flip_h = direction.x < 0
    var collision = move_and_collide(direction * speed * delta)
    if collision:
        direction = direction.bounce(collision.normal)
        sprite.flip_h = direction.x < 0
