class_name Candidate
extends Sprite2D

signal clicked(candidate: Candidate)

const COLOR_NORMAL: Color = Color(1, 1, 1, 0.5)
const COLOR_HOVER: Color = Color.WHITE

@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var coordinate: Vector2i

func _ready() -> void:
	modulate = COLOR_NORMAL

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and \
	event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		clicked.emit(self)

func _on_area_2d_mouse_entered() -> void:
	modulate = COLOR_HOVER
	animation_player.play("rotate")

func _on_area_2d_mouse_exited() -> void:
	modulate = COLOR_NORMAL
	animation_player.stop()
