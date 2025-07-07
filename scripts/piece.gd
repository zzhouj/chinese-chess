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

func get_boundary_box() -> Vector4i:
	return Vector4i.ZERO

func get_move_directions() -> Array[Vector2i]:
	return []

func get_move_steps() -> int:
	return 1

func check_boundary_box(coordinate: Vector2i, box: Vector4i) -> bool:
	return coordinate.x >= box.x and coordinate.x <= box.z and \
		coordinate.y >= box.y and coordinate.y <= box.w

func check_movable_coordinate(_board: Array[Array], _coordinate: Vector2i) -> bool:
	return true

func search_movable_coordinates(board: Array[Array]) -> Array[Vector2i]:
	var coordinates: Array[Vector2i] = []
	for direction: Vector2i in get_move_directions():
		var coordinate: Vector2i = self.coordinate
		for step: int in get_move_steps():
			coordinate += direction
			if not check_boundary_box(coordinate, get_boundary_box()):
				break
			var piece = board[coordinate.x][coordinate.y]
			if piece == null or color != piece.color:
				if check_movable_coordinate(board, coordinate):
					coordinates.append(coordinate)
			if piece != null:
				break
	return coordinates

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and \
	event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var local_pos = to_local(event.position)
		var rect = Rect2(-region_rect.size / 2, region_rect.size)
		if rect.has_point(local_pos):
			clicked.emit(self)
