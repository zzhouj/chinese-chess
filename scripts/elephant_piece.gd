class_name ElephantPiece
extends Piece

func get_boundary_box() -> Vector4i:
	if color == COLOR.RED:
		return Vector4i(0, 0, 8, 4)
	else:
		return Vector4i(0, 5, 8, 9)

func get_move_directions() -> Array[Vector2i]:
	return [
		Vector2i.UP + Vector2i.LEFT,
		Vector2i.UP + Vector2i.RIGHT,
		Vector2i.DOWN + Vector2i.LEFT,
		Vector2i.DOWN + Vector2i.RIGHT,
	]

func get_move_steps() -> int:
	return 2

func check_movable_coordinate(_board: Array[Array], coordinate: Vector2i) -> bool:
	return coordinate.distance_squared_to(self.coordinate) > 2
