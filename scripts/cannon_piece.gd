class_name CannonPiece
extends Piece

func get_boundary_box() -> Vector4i:
	return Vector4i(0, 0, 8, 9)

func get_move_directions() -> Array[Vector2i]:
	return [
		Vector2i.UP,
		Vector2i.DOWN,
		Vector2i.LEFT,
		Vector2i.RIGHT,
	]

func get_move_steps() -> int:
	return 9

func search_movable_coordinates(board: Array[Array]) -> Array[Vector2i]:
	var coordinates: Array[Vector2i] = []
	for direction: Vector2i in get_move_directions():
		var coordinate: Vector2i = self.coordinate
		var piece_count: int = 0
		for step: int in get_move_steps():
			coordinate += direction
			if not check_boundary_box(coordinate, get_boundary_box()):
				break
			var piece = board[coordinate.x][coordinate.y]
			if piece_count == 0:
				if piece == null:
					coordinates.append(coordinate)
				else:
					piece_count += 1
			elif piece_count == 1:
				if piece != null:
					if color != piece.color:
						coordinates.append(coordinate)
					break
	return coordinates
