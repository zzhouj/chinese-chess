extends Node2D

@onready var checker_board: CheckerBoard = %CheckerBoard

func _on_save_button_pressed() -> void:
	checker_board.save_game()

func _on_load_button_pressed() -> void:
	checker_board.load_game()
