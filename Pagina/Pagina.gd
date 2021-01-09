extends Control

const PLAYER_LAYER_BIT = 0

signal pula_pagina()

export(NodePath) var player_position_path = null

var player_position

func _ready() -> void:
    if player_position_path:
        player_position = get_node(player_position_path)

func _pula_pagina():
    emit_signal("pula_pagina")
