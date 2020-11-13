extends Node2D


signal room_cleared


func _ready() -> void:
	for child in get_children():
		child.connect("tree_exited", self, "on_death")	#tree_exited is equivalent to dead


func on_death() -> void:
	QuestJournal.add_kill(1)
	
	var numOfChildren: int = get_child_count()	
	if numOfChildren == 0:
		emit_signal("room_cleared")
