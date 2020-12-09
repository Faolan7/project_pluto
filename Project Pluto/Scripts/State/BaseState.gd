class_name State
extends Node


signal completed


var actor: KinematicBody2D
var is_completed: bool setget set_completed


func activate() -> void:
	set_physics_process(true)
	is_completed = false

func deactivate() -> void:
	set_physics_process(false)


func set_completed(value: bool) -> void:
	is_completed = value
	
	if is_completed:
		emit_signal('completed')
