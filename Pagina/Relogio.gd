extends Panel

onready var timer = $Timer
const timer_format = "%2d:%2d"

func _process(_delta: float) -> void:
    var current_time = OS.get_time()
    timer.text = timer_format % [current_time['hour'], current_time['minute']]
