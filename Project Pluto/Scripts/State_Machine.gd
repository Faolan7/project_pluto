extends Node


class_name State_Machine 


var currentState: State setget change_state


func change_state(newState: State):
	if currentState != null:
		currentState.deactivate()
		
	currentState = newState
	currentState.activate()

