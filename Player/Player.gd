extends KinematicBody2D

const INIMIGO_LAYER_BIT = 2

export(Resource) var score
export(float) var linearVelocity: float = 100
export(bool) var start_pulando = true

var direction = Vector2.ZERO
var pulando = false
var blinking = false

onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var damageAnimationPlayer : AnimationPlayer = $DamageAnimationPlayer

func _ready():
    set_physics_process(true)
    if start_pulando:
        pulando = true
        animationPlayer.play("Pulando")

func _physics_process(_delta):
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

    if Input.is_action_pressed("pulo") and not pulando:
        pulando = true
        animationPlayer.play("Pulando")

    if direction.x != 0 or direction.y != 0:
        direction = direction.normalized()
        if not pulando:
            animationPlayer.play("Move")
    var _v = move_and_slide(direction * linearVelocity)
    for i in get_slide_count():
        var collision = get_slide_collision(i)
        if collision.collider.get_collision_layer_bit(INIMIGO_LAYER_BIT):
            _on_Inimigo_collision(collision.collider)
            break

func _on_Inimigo_collision(inimgo):
    score.points -= inimgo.damage
    set_collision_mask_bit(INIMIGO_LAYER_BIT, false)
    blinking = true
    damageAnimationPlayer.play("Blink")

func _blink_ended():
    blinking = false
    set_collision_mask_bit(INIMIGO_LAYER_BIT, not pulando)

func _pulo_started():
    set_collision_mask_bit(INIMIGO_LAYER_BIT, false)

func _pulo_ended():
    set_collision_mask_bit(INIMIGO_LAYER_BIT, not blinking)
    pulando = false
