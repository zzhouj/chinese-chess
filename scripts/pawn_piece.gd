class_name PawnPiece
extends Piece

func get_boundary_box() -> Vector4i:
	return Vector4i(0, 0, 8, 9)

func get_move_directions() -> Array[Vector2i]:
	if color == COLOR.RED:
		if coordinate.y >= 5:
			return [
				Vector2i.DOWN,
				Vector2i.LEFT,
				Vector2i.RIGHT,
			]
		else:
			return [
				Vector2i.DOWN,
			]
	else:
		if coordinate.y <= 4:
			return [
				Vector2i.UP,
				Vector2i.LEFT,
				Vector2i.RIGHT,
			]
		else:
			return [
				Vector2i.UP,
			]
