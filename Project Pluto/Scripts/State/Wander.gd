class_name WanderState
extends MoveState


onready var update_timer: Timer = $Timer

export(float) var CHANCE_TO_WAIT: float = .5


func activate() -> void:
	.activate()
	set_completed(true)
	update_timer.start()

func deactivate() -> void:
	.deactivate()
	update_timer.stop()


func _on_update_move_dir() -> void:
	if randf() <= CHANCE_TO_WAIT:
		move_dir = Vector2.ZERO
		actor.play_animation('idle')
	else:
		move_dir = Vector2.RIGHT.rotated(rand_range(0, TAU))
		actor.face_dir = move_dir
		actor.play_animation('move')
