extends Node2D


signal room_cleared


func _ready():
	for child in get_children():
		child.connect("tree_exited", self, "on_death")	#tree_exited is equivalent to dead


func on_death() -> void:
	QuestJournal.check_for_enemy_in_journal(1)
	
	var numOfChildren = get_child_count()	
	if numOfChildren == 0:
		emit_signal("room_cleared")
