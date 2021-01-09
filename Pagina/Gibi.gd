extends Control

export(Resource) var score
export(float) var turn_duration = 1
export(Array, PackedScene) var pages : Array = []

onready var page_holder_left = $PageHolderLeft
onready var page_holder_right = $PageHolderRight
onready var tween = $Tween
onready var player = $Player
onready var hud = get_node("../CanvasLayer/HUD")

var current_page = 0
var page_left : Control = null
var page_right : Control = null

func next_page() -> Node:
    var page = pages[current_page]
    current_page = (current_page + 1) % pages.size()
    return page.instance()

func _ready():
    assert(pages.size() % 2 == 0, "Número de páginas deve ser par!!!")
    page_left = next_page()
    page_left.connect("pula_pagina", self, "_pula_pagina")
    page_holder_left.add_child(page_left)
    on_restart()

    page_right = next_page()
    page_holder_right.add_child(page_right)
    page_right.connect("pula_pagina", self, "_pula_pagina")

#    yield(get_tree().create_timer(1), "timeout")
#    _pula_pagina()

func _pula_pagina():
    if current_page == 0:
        on_restart()

    # Fade Out das páginas atuais
    tween.interpolate_property(page_left, "modulate:a", 1, 0, turn_duration)
    tween.interpolate_property(page_right, "modulate:a", 1, 0, turn_duration)
    tween.start()
    yield(tween, "tween_all_completed")

    # Limpeza
    page_left.disconnect("pula_pagina", self, "_pula_pagina")
    page_left.queue_free()
    page_right.disconnect("pula_pagina", self, "_pula_pagina")
    page_right.queue_free()

    # Cria as novas e Fade In
    page_left = next_page()
    page_right = next_page()

    page_left.connect("pula_pagina", self, "_pula_pagina")
    page_left.modulate.a = 0
    page_holder_left.add_child(page_left)
    tween.interpolate_property(page_left, "modulate:a", 0, 1, turn_duration)

    page_right.connect("pula_pagina", self, "_pula_pagina")
    page_right.modulate.a = 0
    page_holder_right.add_child(page_right)
    tween.interpolate_property(page_right, "modulate:a", 0, 1, turn_duration)

    if current_page == 0:
        on_gameover()

    tween.start()

func on_gameover():
    score.paused = true

func on_restart():
    if page_left.player_position:
        player.global_position = page_left.player_position.global_position
    score.reset()
    hud.reset()
