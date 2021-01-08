extends MoveState


export var WAIT_CHANCE: float = .5

onready var update_timer: Timer = $Timer


func activate() -> void:
	.activate()
	set_completed(true)
	update_timer.start()

func deactivate() -> void:
	.deactivate()
	update_timer.stop()


func _on_update_move_dir() -> void:
	if randf() <= WAIT_CHANCE:
		move_dir = Vector2.ZERO
	else:
		move_dir = Vector2.RIGHT.rotated(rand_range(0, TAU))
