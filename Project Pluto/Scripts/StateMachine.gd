class_name StateMachine
extends Node


var current_state: State

export(NodePath) var ACTOR_NODE: NodePath # Path to the actor node


func _ready():
	var actor: KinematicBody2D = get_node(ACTOR_NODE) as KinematicBody2D
	
	for child in get_children():
		var state: State = child as State
		
		state.deactivate()
		state.actor = actor


func change_state(new_state: State):
	if current_state != null:
		current_state.deactivate()
		
	current_state = new_state
	current_state.activate()
