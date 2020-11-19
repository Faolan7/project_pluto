extends Node2D


signal room_cleared


func _ready() -> void:
	for child in get_children():
		child.connect('died', self, '_on_death')


func _on_death() -> void:
	QuestJournal.add_kill(1)
	
	var is_cleared: bool = true
	
	# Checking if all enemies are killed
	for enemy in get_children():
		if not enemy.is_dead:
			is_cleared = false
			break
			
	if is_cleared:
		emit_signal("room_cleared")
