extends MoveState

onready var update_timer: Timer = $Timer

export var WAIT_CHANCE: float = .5

func activate() -> void:
	.activate()
	update_timer.start()
	set_completed(true)

func deactivate() -> void:
	.deactivate()
	update_timer.stop()
	

func _on_update_move_dir() -> void:
	var do_wait = randf() <= WAIT_CHANCE
	if do_wait:
		move_dir = Vector2.ZERO
	else:
		move_dir = Vector2.RIGHT.rotated(rand_range(0,TAU))
