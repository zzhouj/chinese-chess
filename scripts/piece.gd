class_name Piece
extends Sprite2D

enum COLOR {RED, BLACK}
enum TYPE {KING, ADVISOR, ELEPHANT, KNIGHT, ROOK, CANNON, PAWN}

const _SYMBOL: Array[String] = ["K", "A", "E", "N", "R", "C", "P"]
const _RED_NAME: Array[String] = ["帅", "仕", "相", "马", "车", "炮", "兵"]
const _BLACK_NAME: Array[String] = ["将", "士", "象", "马", "车", "炮", "卒"]

@export var color: COLOR
@export var type: TYPE
@export var coordinate: Vector2i

signal clicked(piece: Piece)

func get_symbol() -> String:
	return _SYMBOL[type] + \
	String.chr("a".unicode_at(0) + coordinate.x) + \
	String.chr("0".unicode_at(0) + coordinate.y)

func get_chinese_name() -> String:
	if color == COLOR.RED:
		return _RED_NAME[type]
	else:
		return _BLACK_NAME[type]

func search_movable_coordinates(board: Array[Array]) -> Array[Vector2i]:
	return []

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and \
	event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var local_pos = to_local(event.position)
		var rect = Rect2(-region_rect.size / 2, region_rect.size)
		if rect.has_point(local_pos):
			clicked.emit(self)
