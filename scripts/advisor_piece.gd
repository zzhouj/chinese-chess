class_name AdvisorPiece
extends KingPiece

func get_directions() -> Array[Vector2i]:
	return [
		Vector2i.UP + Vector2i.LEFT,
		Vector2i.UP + Vector2i.RIGHT,
		Vector2i.DOWN + Vector2i.LEFT,
		Vector2i.DOWN + Vector2i.RIGHT,
	]
