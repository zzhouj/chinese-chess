class_name KingPiece
extends AdvisorPiece

func get_move_directions() -> Array[Vector2i]:
	return [
		Vector2i.UP,
		Vector2i.DOWN,
		Vector2i.LEFT,
		Vector2i.RIGHT,
	]

func check_movable_coordinate(board: Array[Array], coordinate: Vector2i) -> bool:
	var direction: Vector2i
	if color == COLOR.RED:
		direction = Vector2i.DOWN
	else:
		direction = Vector2i.UP
	while coordinate.y >= 0 and coordinate.y <= 9:
		var piece = board[coordinate.x][coordinate.y]
		if piece != null:
			if piece != self and piece.type == Piece.TYPE.KING:
				return false
			else:
				return true
		coordinate += direction
	return true
