class_name CheckerBoard
extends Sprite2D

const BOARD_COLS := 9
const BOARD_ROWS := 10

const BOARD_NW := Vector2(64, 57)
const BOARD_SE := Vector2(1072, 1230)

const COL_WIDTH := (BOARD_SE.x - BOARD_NW.x) / (BOARD_COLS - 1)
const ROW_HEIGHT := (BOARD_SE.y - BOARD_NW.y) / (BOARD_ROWS - 1)

const RED_KING_PIECE = preload("res://scenes/red_king_piece.tscn")
const BLACK_KING_PIECE = preload("res://scenes/black_king_piece.tscn")

var board: Array[Array] = []

func _init() -> void:
	for i:int in BOARD_COLS:
		var row := []
		for j:int in BOARD_ROWS:
			row.append(null)
		board.append(row)

func _ready() -> void:
	add_piece(RED_KING_PIECE.instantiate(), Vector2i(4, 0))
	add_piece(BLACK_KING_PIECE.instantiate(), Vector2i(4, 9))

func add_piece(piece: Piece, coordinate: Vector2i) -> void:
	if coordinate.x >= 0 and coordinate.x < BOARD_COLS:
		if coordinate.y >= 0 and coordinate.y < BOARD_ROWS:
			piece.coordinate = coordinate
			board[coordinate.x][coordinate.y] = piece
			piece.position = get_position_from_coordinate(coordinate)
			add_child(piece)

func get_position_from_coordinate(coordinate: Vector2i) -> Vector2:
	return BOARD_NW + Vector2(coordinate.x * COL_WIDTH, (BOARD_ROWS - 1 - coordinate.y) * ROW_HEIGHT)
