class_name CheckerBoard
extends Sprite2D

const BOARD_COLS := 9
const BOARD_ROWS := 10

const BOARD_NW := Vector2(64, 57)
const BOARD_SE := Vector2(1072, 1230)

const COL_WIDTH := (BOARD_SE.x - BOARD_NW.x) / (BOARD_COLS - 1)
const ROW_HEIGHT := (BOARD_SE.y - BOARD_NW.y) / (BOARD_ROWS - 1)

const RED_INIT_SYMBOLS: Array[String] = [
	"Ke0",
	"Ad0", "Af0",
	"Ec0", "Eg0",
	"Nb0", "Nh0",
	"Ra0", "Ri0",
	"Cb2", "Ch2",
	"Pa3", "Pc3", "Pe3", "Pg3", "Pi3",
]

const BLACK_INIT_SYMBOLS: Array[String] = [
	"Ke9",
	"Ad9", "Af9",
	"Ec9", "Eg9",
	"Nb9", "Nh9",
	"Ra9", "Ri9",
	"Cb7", "Ch7",
	"Pa6", "Pc6", "Pe6", "Pg6", "Pi6",
]

var board: Array[Array] = []
var current_round: Piece.COLOR = Piece.COLOR.RED
var selected_piece: Piece = null
var game_histories: Array[String] = []

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

	set_current_round(current_round)

func add_piece(piece: Piece) -> void:
	var coordinate: Vector2i = piece.coordinate
	if coordinate.x >= 0 and coordinate.x < BOARD_COLS and \
	coordinate.y >= 0 and coordinate.y < BOARD_ROWS:
		board[coordinate.x][coordinate.y] = piece
		piece.position = get_position_from_coordinate(coordinate)
		piece.clicked.connect(_on_piece_clicked)
		piece.moved.connect(_on_piece_moved)
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

func next_round() -> void:
	clear_candidates()
	if current_round == Piece.COLOR.RED:
		set_current_round(Piece.COLOR.BLACK)
	else:
		set_current_round(Piece.COLOR.RED)

func clear_candidates() -> void:
	get_tree().call_group("candidate", "queue_free")
	if selected_piece != null:
		selected_piece.set_selected(false)
	selected_piece = null

func set_current_round(next_round: Piece.COLOR) -> void:
	current_round = next_round
	if current_round == Piece.COLOR.RED:
		get_tree().call_group("red", "set_pickable", true)
		get_tree().call_group("black", "set_pickable", false)
	else:
		get_tree().call_group("red", "set_pickable", false)
		get_tree().call_group("black", "set_pickable", true)

func _on_piece_clicked(piece: Piece) -> void:
	clear_candidates()
	piece.set_selected(true)
	selected_piece = piece
	var coordinates: Array[Vector2i] = piece.search_movable_coordinates(board)
	for coordinate: Vector2i in coordinates:
		add_candidate(CandidateFactory.build(coordinate))

func _on_piece_moved(piece: Piece) -> void:
	var coordinate: Vector2i = piece.coordinate
	var eaten_piece: Piece = board[coordinate.x][coordinate.y]
	if eaten_piece != null:
		eaten_piece.queue_free()
	board[coordinate.x][coordinate.y] = piece

func _on_candidate_clicked(candidate: Candidate) -> void:
	assert(selected_piece != null, "selected_piece must not null.")
	var coordinate: Vector2i = selected_piece.coordinate
	board[coordinate.x][coordinate.y] = null
	var orig_sym: String = selected_piece.get_symbol()
	selected_piece.coordinate = candidate.coordinate
	var dest_sym: String = selected_piece.get_symbol()
	selected_piece.target_position = get_position_from_coordinate(candidate.coordinate)
	var eaten: bool = board[candidate.coordinate.x][candidate.coordinate.y] != null
	add_histories(orig_sym, dest_sym, eaten)
	next_round()

func add_histories(orig_sym: String, dest_sym: String, eaten: bool) -> void:
	var action: String = "-"
	if eaten:
		action = "x"
	var history = orig_sym + action + dest_sym.substr(1)
	print(history)
	game_histories.append(history)
