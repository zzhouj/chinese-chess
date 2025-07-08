class_name PieceFactory
extends RefCounted

const PIECE: PackedScene = preload("res://scenes/piece.tscn")

const TYPES: Dictionary[String, Piece.TYPE] = {
	"K": Piece.TYPE.KING,
	"A": Piece.TYPE.ADVISOR,
	"E": Piece.TYPE.ELEPHANT,
	"N": Piece.TYPE.KNIGHT,
	"R": Piece.TYPE.ROOK,
	"C": Piece.TYPE.CANNON,
	"P": Piece.TYPE.PAWN,
}

const RED_REGION_RECTS: Dictionary[String, Rect2] = {
	"K": Rect2(650, 144, 220, 220),
	"A": Rect2(652, 387, 219, 219),
	"E": Rect2(918, 391, 220, 219),
	"N": Rect2(920, 635, 220, 220),
	"R": Rect2(654, 633, 219, 220),
	"C": Rect2(656, 902, 220, 219),
	"P": Rect2(922, 904, 220, 220),
}

const BLACK_REGION_RECTS: Dictionary[String, Rect2] = {
	"K": Rect2(394, 142, 220, 219),
	"A": Rect2(396, 387, 220, 219),
	"E": Rect2(142, 389, 220, 219),
	"N": Rect2(144, 652, 220, 220),
	"R": Rect2(397, 650, 220, 220),
	"C": Rect2(398, 908, 220, 220),
	"P": Rect2(144, 906, 220, 220),
}

const SCRIPTS: Dictionary[String, GDScript] = {
	"K": preload("res://scripts/king_piece.gd"),
	"A": preload("res://scripts/advisor_piece.gd"),
	"E": preload("res://scripts/elephant_piece.gd"),
	"N": preload("res://scripts/knight_piece.gd"),
	"R": preload("res://scripts/rook_piece.gd"),
	"C": preload("res://scripts/cannon_piece.gd"),
	"P": preload("res://scripts/pawn_piece.gd"),
}

static func build(color: Piece.COLOR, symbol: String) -> Piece:
	assert(symbol.length() == 3, "symbol's length must be 3.")
	var s := symbol[0]
	var piece: Piece = PIECE.instantiate()
	piece.set_script(SCRIPTS[s])
	piece.color = color
	piece.type = TYPES[s]
	if color == Piece.COLOR.RED:
		piece.region_rect = RED_REGION_RECTS[s]
	else:
		piece.region_rect = BLACK_REGION_RECTS[s]
	var x := symbol.unicode_at(1) - "a".unicode_at(0)
	var y := symbol.unicode_at(2) - "0".unicode_at(0)
	piece.coordinate = Vector2i(x, y)
	return piece
