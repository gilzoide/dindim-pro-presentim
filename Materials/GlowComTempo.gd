extends Node

const GLOW_SPEED = 0.7

var material : ShaderMaterial = preload("res://Materials/OutlineGlowMaterial.tres")
var time = 0

func _ready() -> void:
    randomize()

func _process(delta: float) -> void:
    time += delta
    var color = material.get_shader_param("outline_color")
    color.a = abs(sin(time * GLOW_SPEED))
    material.set_shader_param("outline_color", color)
