extends Control

export(Resource) var score
export(String) var score_format = "$ %d"
onready var score_label : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	score.connect("points_changed", self, "_on_Score_points_changed")
	update_score(score.points)

func update_score(value):
	score_label.text = score_format % value

func _on_Score_points_changed(new_value, _old_value):
	update_score(new_value)
