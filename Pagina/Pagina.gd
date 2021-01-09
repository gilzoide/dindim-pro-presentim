extends Control

const PLAYER_LAYER_BIT = 0

signal pula_pagina()
signal player_pulou()

export(NodePath) var player_position_path
var player_position
var player

func _ready() -> void:
    if player_position_path:
        player_position = get_node(player_position_path)

func _on_Player_na_area(body : PhysicsBody2D) -> void:
    if body.get_collision_layer_bit(PLAYER_LAYER_BIT):
        player = body
        player.connect("comecou_pular", self, "emit_signal", ["player_pulou"])

func _on_Player_fora_da_area(body : PhysicsBody2D) -> void:
    if body.get_collision_layer_bit(PLAYER_LAYER_BIT):
        assert(player != null and player == body)
        player.disconnect("comecou_pular", self, "emit_signal")

func _pula_pagina():
    emit_signal("pula_pagina")
