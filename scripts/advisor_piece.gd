class_name AdvisorPiece
extends Piece

func get_boundary_box() -> Vector4i:
	if color == COLOR.RED:
		return Vector4i(3, 0, 5, 2)
	else:
		return Vector4i(3, 7, 5, 9)

func get_move_directions() -> Array[Vector2i]:
	return [
		Vector2i.UP + Vector2i.LEFT,
		Vector2i.UP + Vector2i.RIGHT,
		Vector2i.DOWN + Vector2i.LEFT,
		Vector2i.DOWN + Vector2i.RIGHT,
	]
