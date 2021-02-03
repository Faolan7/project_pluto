class_name KillTask
extends Task


var ENEMY_ID: int
var NUM_TO_KILL: int
var num_killed: int = 0


static func init(enemy_id: int, quantity: int) -> KillTask:
	var task: KillTask = load("res://Scripts/Quest/KillTask.gd").new() as KillTask
	task.ENEMY_ID = enemy_id
	task.NUM_TO_KILL = quantity
	
	return task

func add_kill(enemy_id: int) -> void:
	if ENEMY_ID == enemy_id:
		num_killed += 1
		
		if get_complete():
			emit_signal('completed')


func get_complete() -> bool:
	return num_killed >= NUM_TO_KILL
