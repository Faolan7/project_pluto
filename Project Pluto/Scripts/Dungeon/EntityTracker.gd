class_name EntityTracker
extends YSort


signal room_cleared


func _ready() -> void:
	for child in get_children():
		if child is Enemy:
			child.connect('died', self, '_on_death')


func remove_enemies() -> void:
	for child in get_children():
		if child is Enemy:
			remove_child(child)

func has_enemies() -> bool:
	for child in get_children():
		if child is Enemy and not child.is_dead:
			return true
			
	return false


func _on_death() -> void:
	QuestJournal.add_kill(1)
	
	if not has_enemies():
		emit_signal('room_cleared')
