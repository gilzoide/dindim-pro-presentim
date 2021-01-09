extends Control

export(Resource) var score
export(String) var score_format = "$ %d"
export(String) var plus_score_format = " %+d"
export(String) var minus_score_format = "  %d"
export(Color) var plus_color = Color.greenyellow
export(Color) var minus_color = Color.red

onready var score_label : Label = $Label
onready var update_label : Label = $Label/UpdateLabel
onready var animation_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
    score.connect("points_changed", self, "_on_Score_points_changed")
    reset()

func reset():
    if score_label:
        update_score(score.points)

func update_score(value):
    score_label.text = score_format % value

func _on_Score_points_changed(new_value, old_value):
    update_score(new_value)
    var delta = new_value - old_value
    animation_player.stop()
    if delta < 0:
        update_label.text = minus_score_format % delta
        update_label.self_modulate = minus_color
    else:
        update_label.text = plus_score_format % delta
        update_label.self_modulate = plus_color
    animation_player.play("MostraUpdate")
