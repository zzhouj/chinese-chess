class_name KingPiece
extends Piece

const RED_BOX := Vector4i(3, 0, 5, 2)
const BLACK_BOX := Vector4i(3, 7, 5, 9)

func get_directions() -> Array[Vector2i]:
	return [
		Vector2i.UP,
		Vector2i.DOWN,
		Vector2i.LEFT,
		Vector2i.RIGHT,
	]

func search_movable_coordinates(board: Array[Array]) -> Array[Vector2i]:
	var coords: Array[Vector2i] = []
	var box: Vector4i
	if color == COLOR.RED:
		box = RED_BOX
	else:
		box = BLACK_BOX
	for dir: Vector2i in get_directions():
		var coord = coordinate + dir
		if coord.x >= box.x and coord.x <= box.z and \
		coord.y >= box.y and coord.y <= box.w:
			var piece = board[coord.x][coord.y]
			if piece == null or color != piece.color:
				coords.append(coord)
	return coords
