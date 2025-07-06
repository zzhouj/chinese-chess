class_name ElephantPiece
extends Piece

func get_boundary_box() -> Vector4i:
	if color == COLOR.RED:
		return Vector4i(0, 0, 8, 4)
	else:
		return Vector4i(0, 5, 8, 9)

func get_move_directions() -> Array[Vector2i]:
	return [
		(Vector2i.UP + Vector2i.LEFT) * 2,
		(Vector2i.UP + Vector2i.RIGHT) * 2,
		(Vector2i.DOWN + Vector2i.LEFT) * 2,
		(Vector2i.DOWN + Vector2i.RIGHT) * 2,
	]
