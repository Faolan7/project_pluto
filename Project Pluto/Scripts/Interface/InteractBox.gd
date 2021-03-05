class_name InteractBox
extends Area2D


signal interaction_started(player)
signal interaction_finished


func interact(player) -> void:
	emit_signal('interaction_started', player)

func finish_interaction(delete: bool = false) -> void:
	if delete:
		queue_free()
	emit_signal('interaction_finished')
