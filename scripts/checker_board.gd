class_name CheckerBoard
extends Sprite2D

const BOARD_COLS := 9
const BOARD_ROWS := 10

const BOARD_NW := Vector2(64, 57)
const BOARD_SE := Vector2(1072, 1230)

const COL_WIDTH := (BOARD_SE.x - BOARD_NW.x) / (BOARD_COLS - 1)
const ROW_HEIGHT := (BOARD_SE.y - BOARD_NW.y) / (BOARD_ROWS - 1)

const RED_INIT_SYMBOLS: Array[String] = [
	"Kd1",
	"Ad0",
	"Af0",
	"Ec0",
	"Eg0",
]

const BLACK_INIT_SYMBOLS: Array[String] = [
	"Ke9",
	"Ae8",
	"Af9",
	"Ec9",
	"Eg9",
]

var board: Array[Array] = []

func _init() -> void:
	for i:int in BOARD_COLS:
		var row := []
		for j:int in BOARD_ROWS:
			row.append(null)
		board.append(row)

func _ready() -> void:
	for symbol:String in RED_INIT_SYMBOLS:
		var piece: Piece = PieceFactory.create(Piece.COLOR.RED, symbol)
		add_piece(piece, piece.coordinate)

	for symbol:String in BLACK_INIT_SYMBOLS:
		var piece: Piece = PieceFactory.create(Piece.COLOR.BLACK, symbol)
		add_piece(piece, piece.coordinate)

func add_piece(piece: Piece, coordinate: Vector2i) -> void:
	if coordinate.x >= 0 and coordinate.x < BOARD_COLS:
		if coordinate.y >= 0 and coordinate.y < BOARD_ROWS:
			piece.coordinate = coordinate
			board[coordinate.x][coordinate.y] = piece
			piece.position = get_position_from_coordinate(coordinate)
			add_child(piece)
			piece.clicked.connect(_on_piece_clicked)
			board[coordinate.x][coordinate.y] = piece

func get_position_from_coordinate(coordinate: Vector2i) -> Vector2:
	return BOARD_NW + Vector2(\
	coordinate.x * COL_WIDTH, \
	(BOARD_ROWS - 1 - coordinate.y) * ROW_HEIGHT)

func _on_piece_clicked(piece: Piece) -> void:
	var coordinates: Array[Vector2i] = piece.search_movable_coordinates(board)
	print(piece.get_symbol(), coordinates)
