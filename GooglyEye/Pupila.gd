extends RigidBody2D

export(float) var clamp_speed_on_too_far = 500

onready var parent = get_node("..")
onready var radius = get_node("../Fundo").texture.get_width() * 0.5
onready var squared_radius = radius * radius
onready var self_radius = get_node("Sprite").texture.get_width() * 0.5
onready var squared_self_radius = self_radius * self_radius

func _integrate_forces(state):
	var origin : Vector2 = state.transform.origin
	var delta : Vector2 = origin - parent.global_position
	var squared_length = delta.length_squared() - squared_self_radius
	if squared_length > squared_radius:
		if squared_length > squared_radius * 2:
			linear_velocity = linear_velocity.clamped(clamp_speed_on_too_far)
		delta *= radius / sqrt(squared_length)
		state.transform.origin -= delta
