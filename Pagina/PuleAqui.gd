extends Label

export(NodePath) var pagina_root_path
onready var pagina_root = get_node(pagina_root_path)

func _player_pulou():
    pagina_root._pula_pagina()
