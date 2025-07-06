class_name Piece
extends Sprite2D

enum COLOR {RED, BLACK}
enum TYPE {KING, ADVISOR, ELEPHANT, KNIGHT, ROOK, CANNON, PAWN}

const _SYMBOL: Array[String] = ["K", "A", "E", "N", "R", "C", "P"]
const _RED_NAME: Array[String] = ["帅", "仕", "相", "马", "车", "炮", "兵"]
const _BLACK_NAME: Array[String] = ["将", "士", "象", "马", "车", "炮", "卒"]

@export var color: COLOR
@export var type: TYPE
@export var coordinate: Vector2i
