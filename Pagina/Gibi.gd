extends Control

export(float) var turn_duration = 1
export(Array, PackedScene) var pages : Array = []

onready var page_holder_left = $PageHolderLeft
onready var page_holder_right = $PageHolderRight
onready var tween = $Tween
onready var player = $Player

var page_left : Control = null
var page_right : Control = null

# Called when the node enters the scene tree for the first time.
func _ready():
    assert(pages.size() % 2 == 0, "Número de páginas deve ser par!!!")
    page_left = pages.pop_front().instance()
    page_holder_left.add_child(page_left)
    player.global_position = page_left.player_position.global_position

    page_right = pages.pop_front().instance()
    page_holder_right.add_child(page_right)
    page_right.connect("pula_pagina", self, "_pula_pagina")

func _pula_pagina():
    pass

#    yield(get_tree().create_timer(2), "timeout")
#    turn_page()
#
#func turn_page():
#    var current_page_left = page_left
#    page_left = pages.pop_front().instance()
#    page_holder_left_viewport_container.rect_scale.x = 0
#    page_holder_left_viewport.add_child(page_left)
#
#    var current_page_right = page_right
#    page_right = pages.pop_front().instance()
#    page_holder_right.add_child(page_right)
#    page_holder_right.remove_child(current_page_right)
#    page_holder_right_viewport.add_child(current_page_right)
#
#    yield(get_tree(), "idle_frame")
#    tween.interpolate_property(page_holder_right_viewport_container, "rect_scale:x", 1, 0, turn_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
#    tween.start()
#    yield(tween, "tween_completed")
#    current_page_right.queue_free()
#
#    yield(get_tree(), "idle_frame")
#    tween.interpolate_property(page_holder_left_viewport_container, "rect_scale:x", 0, 1, turn_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
#    tween.start()
#    yield(tween, "tween_completed")
#    current_page_left.queue_free()
#    page_holder_left_viewport.remove_child(page_left)
#    page_holder_left.add_child(page_left)

