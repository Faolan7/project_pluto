class_name InteractBox
extends Area2D

signal interaction_started
signal interaction_finished


func interact() -> void:
	emit_signal('interaction_started')

func finish_interaction() -> void:
	emit_signal('interaction_finished')
