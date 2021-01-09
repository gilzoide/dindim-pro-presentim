extends Label

export(Resource) var score
export(String) var format = """Parabéns!

Você coletou %d dinheiros
Em %d:%02d

%s
"""

export(Array, String) var messages_zero_points = []
export(Array, String) var messages_points = []

func _ready() -> void:
    var minutes = score.time / 60
    var seconds = int(round(score.time)) % 60

    var message = messages_zero_points[randi() % messages_zero_points.size()] \
                  if score.points == 0 \
                  else messages_points[randi() % messages_points.size()]
    text = format % [
        score.points,
        minutes, seconds,
        message
    ]
