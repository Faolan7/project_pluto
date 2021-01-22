extends YSort


signal room_cleared


var num_enemies: int = 0


func _ready() -> void:
	for child in get_children():
		if child is Enemy:
			num_enemies += 1
			child.connect('died', self, '_on_death')


func remove_enemies() -> void:
	for child in get_children():
		if child is Enemy:
			remove_child(child)

func has_enemies() -> bool:
	for child in get_children():
		if child is Enemy:
			return true
			
	return false


func _on_death() -> void:
	QuestJournal.add_kill(1)
	num_enemies -= 1
	
	if num_enemies <= 0:
		emit_signal('room_cleared')
