tool
extends Area2D

const JOGADOR_LAYER_BIT = 0
const CELL_WIDTH = 32

export(Resource) var score

enum Value {
    UMA,
    DUAS,
    QUATRO,
    OITO,
    DEZESSEIS,
    CALICE,
    BARRAS,
    BAU,
    COROA,
    TESOURO,
}
export(Value) var value setget set_value

var points = 1
onready var sprite : Sprite = $Sprite

func _ready() -> void:
    set_value(value)

func set_value(new_value):
    value = new_value
    points = 1 << value
    if sprite:
        sprite.region_rect = Rect2(
            Vector2(value * CELL_WIDTH, 0),
            Vector2(CELL_WIDTH, CELL_WIDTH)
        )

func _on_Moeda_body_entered(body : PhysicsBody2D):
    if body.get_collision_layer_bit(JOGADOR_LAYER_BIT):
        score.points += points
        queue_free()
