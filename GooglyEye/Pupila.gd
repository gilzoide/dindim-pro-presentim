extends RigidBody2D

onready var parent = get_node("..")
onready var radius = get_node("../Fundo").texture.get_width() * 0.5
onready var squared_radius = radius * radius

func _integrate_forces(state):
	var origin : Vector2 = state.transform.origin
	var delta : Vector2 = origin - parent.global_position
	var squared_length = delta.length_squared()
	if squared_length > squared_radius:
		delta *= radius / sqrt(squared_length)
		state.transform.origin -= delta
