extends Resource

class_name Score

export(float) var points = 0 setget set_points
signal points_changed(new_value, old_value)

func set_points(new_points):
	var old_points = points
	points = max(new_points, 0)
	emit_signal("points_changed", points, old_points)
