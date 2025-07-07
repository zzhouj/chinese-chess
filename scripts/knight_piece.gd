class_name KnightPiece
extends Piece

func get_boundary_box() -> Vector4i:
	return Vector4i(0, 0, 8, 9)

func get_move_directions() -> Array[Vector2i]:
	return [
		Vector2i.UP, Vector2i.UP + Vector2i.LEFT,
		Vector2i.UP, Vector2i.UP + Vector2i.RIGHT,
		Vector2i.DOWN, Vector2i.DOWN + Vector2i.LEFT,
		Vector2i.DOWN, Vector2i.DOWN + Vector2i.RIGHT,
		Vector2i.LEFT, Vector2i.LEFT + Vector2i.UP,
		Vector2i.LEFT, Vector2i.LEFT + Vector2i.DOWN,
		Vector2i.RIGHT, Vector2i.RIGHT + Vector2i.UP,
		Vector2i.RIGHT, Vector2i.RIGHT + Vector2i.DOWN,
	]

func check_movable_coordinate(_board: Array[Array], coordinate: Vector2i) -> bool:
	return coordinate.distance_squared_to(self.coordinate) > 2

func search_movable_coordinates(board: Array[Array]) -> Array[Vector2i]:
	var coordinates: Array[Vector2i] = []
	var directions: Array[Vector2i] = get_move_directions()
	for i: int in directions.size() / 2:
		var coordinate: Vector2i = self.coordinate
		for direction: Vector2i in [directions[i * 2], directions[i * 2 + 1]]:
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
