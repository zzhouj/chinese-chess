class_name RookPiece
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
