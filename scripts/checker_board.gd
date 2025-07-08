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
	"Ne4",
	"Nh0",
	"Ra0",
	"Ri0",
	"Cc2",
	"Ch2",
	"Pa5",
	"Pc4",
	"Pe3",
	"Pg3",
	"Pi3",
]

const BLACK_INIT_SYMBOLS: Array[String] = [
	"Ke9",
	"Ae8",
	"Af9",
	"Ec9",
	"Eg9",
	"Nb9",
	"Nh9",
	"Ra9",
	"Ri8",
	"Cb7",
	"Ch7",
	"Pa6",
	"Pc6",
	"Pe6",
	"Pg4",
	"Pi5",
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
		var piece: Piece = PieceFactory.build(Piece.COLOR.RED, symbol)
		add_piece(piece)

	for symbol:String in BLACK_INIT_SYMBOLS:
		var piece: Piece = PieceFactory.build(Piece.COLOR.BLACK, symbol)
		add_piece(piece)

func add_piece(piece: Piece) -> void:
	var coordinate: Vector2i = piece.coordinate
	if coordinate.x >= 0 and coordinate.x < BOARD_COLS and \
	coordinate.y >= 0 and coordinate.y < BOARD_ROWS:
		board[coordinate.x][coordinate.y] = piece
		piece.position = get_position_from_coordinate(coordinate)
		piece.clicked.connect(_on_piece_clicked)
		add_child(piece)

func add_candidate(candidate: Candidate) -> void:
	var coordinate: Vector2i = candidate.coordinate
	if coordinate.x >= 0 and coordinate.x < BOARD_COLS and \
	coordinate.y >= 0 and coordinate.y < BOARD_ROWS:
		candidate.position = get_position_from_coordinate(coordinate)
		candidate.clicked.connect(_on_candidate_clicked)
		add_child(candidate)

func get_position_from_coordinate(coordinate: Vector2i) -> Vector2:
	return BOARD_NW + Vector2(coordinate.x * COL_WIDTH, \
	(BOARD_ROWS - 1 - coordinate.y) * ROW_HEIGHT)

func _on_piece_clicked(piece: Piece) -> void:
	if piece.selected:
		piece.set_selected(false)
		get_tree().call_group("candidate", "queue_free")
	else:
		get_tree().call_group("piece", "set_selected", false)
		piece.set_selected(true)
		var coordinates: Array[Vector2i] = piece.search_movable_coordinates(board)
		get_tree().call_group("candidate", "queue_free")
		for coordinate: Vector2i in coordinates:
			add_candidate(CandidateFactory.build(coordinate))

func _on_candidate_clicked(candidate: Candidate) -> void:
	print("candidate", candidate.coordinate)
