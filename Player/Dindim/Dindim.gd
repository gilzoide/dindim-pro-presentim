extends Area2D

const JOGADOR_LAYER_BIT = 0

export(float) var points = 1
export(Resource) var score

func _on_Moeda_body_entered(body : PhysicsBody2D):
	if body.get_collision_layer_bit(JOGADOR_LAYER_BIT):
		score.points += points
		queue_free()
