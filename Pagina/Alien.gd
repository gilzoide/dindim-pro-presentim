tool
extends Control

export(float) var speed = 1
export(float) var y_variation = 16
export(Array, String) var falas = []

onready var sprite : TextureRect = $Sprite
onready var label : Label = $Sprite/CaixaTexto2
onready var pos = sprite.rect_position
var time = 0
var current_text = 0

func _ready() -> void:
    label.text = falas[0]

func _process(delta: float) -> void:
    time += delta
    sprite.rect_position = Vector2(0, sin(time * speed) * y_variation)

func _troca_fala():
    current_text = (current_text + 1) % falas.size()
    label.text = falas[current_text]
