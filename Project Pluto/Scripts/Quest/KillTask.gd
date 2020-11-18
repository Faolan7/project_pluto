class_name KillTask
extends Task


var ENEMY_ID: int
var NUM_TO_KILL: int
var num_killed: int = 0


func init(enemy_id: int, quantity: int) -> void:
	ENEMY_ID = enemy_id
	NUM_TO_KILL = quantity

func add_kill(enemy_id: int) -> void:
	if ENEMY_ID == enemy_id:
		num_killed += 1
		
		if get_complete():
			emit_signal('completed')


func get_complete() -> bool:
	return num_killed >= NUM_TO_KILL
