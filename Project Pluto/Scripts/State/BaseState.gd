class_name State
extends Node


var actor: KinematicBody2D
var is_completed: bool


func activate() -> void:
	set_physics_process(true)
	is_completed = true

func deactivate() -> void:
	set_physics_process(false)
