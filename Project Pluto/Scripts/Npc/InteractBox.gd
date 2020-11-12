extends Area2D

signal interaction_started
signal interaction_finished


func interact():
	emit_signal('interaction_started')
