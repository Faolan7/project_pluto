class_name InteractBox
extends Area2D


signal interaction_started(player)
signal interaction_finished


func interact(player) -> void:
	emit_signal('interaction_started', player)

func finish_interaction() -> void:
	emit_signal('interaction_finished')
