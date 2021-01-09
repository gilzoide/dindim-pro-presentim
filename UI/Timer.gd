extends Label

export(Resource) var score
export(String) var timer_format = "%.0f"

func _ready():
    update_timer()

func _process(delta):
    if not score.paused:
        score.time += delta
        update_timer()

func update_timer():
    text = timer_format % score.time
