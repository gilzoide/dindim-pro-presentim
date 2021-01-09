extends CollisionObject2D

const PLAYER_LAYER_BIT = 0

export(NodePath) var controlPath
export(float) var width = 1
export(Color) var color = Color.black

signal player_pulou()

onready var control: Control = get_node(controlPath)
onready var collisionPolygon: CollisionPolygon2D = $CollisionPolygon2D
var player

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

func _on_Player_na_area(body : PhysicsBody2D) -> void:
    if body.get_collision_layer_bit(PLAYER_LAYER_BIT):
        player = body
        player.connect("comecou_pular", self, "emit_signal", ["player_pulou"])

func _on_Player_fora_da_area(body : PhysicsBody2D) -> void:
    if body.get_collision_layer_bit(PLAYER_LAYER_BIT):
        assert(player != null and player == body)
        player.disconnect("comecou_pular", self, "emit_signal")
