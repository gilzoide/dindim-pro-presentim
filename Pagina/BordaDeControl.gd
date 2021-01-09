extends CollisionObject2D

export(NodePath) var controlPath
export(float) var width = 1
export(Color) var color = Color.black

onready var control: Control = get_node(controlPath)
onready var collisionPolygon: CollisionPolygon2D = $CollisionPolygon2D

func _ready():
    if not control:
        push_warning("BordaDeControl sem control settado!!!")
        var parent = get_parent()
        while not parent is Control:
            assert(parent, "BordaDeControl não é descendente de Nós Control!!!")
            parent = get_parent()
        control = parent
    var _err = control.connect("item_rect_changed", self, "_on_control_item_rect_changed")
    update_polygon()

func _draw():
    if width > 0:
        draw_rect(Rect2(Vector2.ZERO, control.rect_size), color, false, width)

func _on_control_item_rect_changed():
    update_polygon()
    update()

func update_polygon():
    var size = control.rect_size
    collisionPolygon.polygon = PoolVector2Array([
        Vector2(0, 0),
        Vector2(0, size.y),
        Vector2(size.x, size.y),
        Vector2(size.x, 0),
    ])
