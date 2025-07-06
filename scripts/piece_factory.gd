class_name PieceFactory
extends RefCounted

const RED_PIECE_SECNES: Dictionary = {
	"K": preload("res://scenes/red_king_piece.tscn"),
	"A": preload("res://scenes/red_advisor_piece.tscn"),
	"E": preload("res://scenes/red_elephant_piece.tscn"),
	#"N",
	#"R",
	#"C",
	#"P",
}

const BLACK_PIECE_SECNES: Dictionary = {
	"K": preload("res://scenes/black_king_piece.tscn"),
	"A": preload("res://scenes/black_advisor_piece.tscn"),
	"E": preload("res://scenes/black_elephant_piece.tscn"),
	#"N",
	#"R",
	#"C",
	#"P",
}

static func create(color: Piece.COLOR, symbol: String) -> Piece:
	assert(symbol.length() == 3, "symbol's length must be 3.")
	var piece:Piece
	if color == Piece.COLOR.RED:
		piece = RED_PIECE_SECNES[symbol[0]].instantiate()
	else:
		piece = BLACK_PIECE_SECNES[symbol[0]].instantiate()
	var coordinate: Vector2i = Vector2i(\
	symbol.unicode_at(1) - "a".unicode_at(0), \
	symbol.unicode_at(2) - "0".unicode_at(0))
	piece.coordinate = coordinate
	return piece
