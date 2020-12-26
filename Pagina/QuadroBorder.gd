extends CollisionPolygon2D

export(NodePath) var controlPath
export(float) var width = 1
export(Color) var color = Color.black

onready var control: Control = get_node(controlPath)

func _ready():
	update_polygon()

func _draw():
	draw_rect(Rect2(Vector2.ZERO, control.rect_size), color, false, width)

func _on_control_item_rect_changed():
	update_polygon()
	update()

func update_polygon():
	var size = control.rect_size
	polygon = PoolVector2Array([
		Vector2(0, 0),
		Vector2(0, size.y),
		Vector2(size.x, size.y),
		Vector2(size.x, 0),
	])
