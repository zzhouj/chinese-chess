class_name Piece
extends Sprite2D

enum COLOR {RED, BLACK}
enum TYPE {KING, ADVISOR, ELEPHANT, KNIGHT, ROOK, CANNON, PAWN}

const _SYMBOL: Array[String] = ["K", "A", "E", "N", "R", "C", "P"]
const _RED_NAME: Array[String] = ["帅", "仕", "相", "马", "车", "炮", "兵"]
const _BLACK_NAME: Array[String] = ["将", "士", "象", "马", "车", "砲", "卒"]

const MOVE_SPEED: float = 800

signal clicked(piece: Piece)
signal moved(piece: Piece)

@onready var area_2d: Area2D = %Area2D
@onready var audio_stream_player: AudioStreamPlayer2D = %AudioStreamPlayer2D

@export var color: COLOR
@export var type: TYPE
@export var coordinate: Vector2i

var selected: bool
var target_position: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if target_position:
		position = position.move_toward(target_position, MOVE_SPEED * delta)
		if position.distance_to(target_position) < 0.1:
			position = target_position
			target_position = Vector2.ZERO
			moved.emit(self)
			audio_stream_player.play()

func get_symbol() -> String:
	return _SYMBOL[type] + \
	String.chr("a".unicode_at(0) + coordinate.x) + \
	String.chr("0".unicode_at(0) + coordinate.y)

func get_chinese_name() -> String:
	if color == COLOR.RED:
		return _RED_NAME[type]
	else:
		return _BLACK_NAME[type]

func get_boundary_box() -> Vector4i:
	return Vector4i.ZERO

func get_move_directions() -> Array[Vector2i]:
	return []

func get_move_steps() -> int:
	return 1

func check_boundary_box(coordinate: Vector2i, box: Vector4i) -> bool:
	return coordinate.x >= box.x and coordinate.x <= box.z and \
		coordinate.y >= box.y and coordinate.y <= box.w

func check_movable_coordinate(_board: Array[Array], _coordinate: Vector2i) -> bool:
	return true

func search_movable_coordinates(board: Array[Array]) -> Array[Vector2i]:
	var coordinates: Array[Vector2i] = []
	for direction: Vector2i in get_move_directions():
		var coordinate: Vector2i = self.coordinate
		for step: int in get_move_steps():
			coordinate += direction
			if not check_boundary_box(coordinate, get_boundary_box()):
				break
			var piece = board[coordinate.x][coordinate.y]
			if piece == null or color != piece.color:
				if check_movable_coordinate(board, coordinate):
					coordinates.append(coordinate)
			if piece != null:
				break
	return coordinates

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and \
	event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		clicked.emit(self)
		audio_stream_player.play()

func _on_area_2d_mouse_entered() -> void:
	modulate = Color.GRAY

func _on_area_2d_mouse_exited() -> void:
	set_selected(selected)

func set_selected(selected: bool) -> void:
	self.selected = selected
	if selected:
		modulate = Color.DARK_GRAY
	else:
		modulate = Color.WHITE

func set_pickable(pickable: bool) -> void:
	area_2d.set_pickable(pickable)
