extends Label

export(float) var time = 0
export(String) var timer_format = "%.0f"

func _ready():
	update_timer()

func _process(delta):
	time += delta
	update_timer()

func update_timer():
	text = timer_format % time
