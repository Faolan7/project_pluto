class_name State
extends Node


var actor: KinematicBody2D


func activate():
	set_physics_process(true)

func deactivate():
	set_physics_process(false)
