class_name PuzzleTracker
extends Node2D


signal room_cleared


func _ready() -> void:
	for child in get_children():
		child.connect('solved', self, '_on_element_solved')


func complete_puzzles() -> void:
	for child in get_children():
		child.is_solved = true

func has_puzzles() -> bool:
	return get_child_count() > 0



func _on_element_solved() -> void:
	for child in get_children():
		if not child.is_solved:
			return
			
	emit_signal('room_cleared')
