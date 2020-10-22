class_name StateMachine
extends Node


var current_state: State


func change_state(new_state: State):
	if current_state != null:
		current_state.deactivate()
		
	current_state = new_state
	current_state.activate()
