extends KinematicBody2D


onready var state_machine = $State_Machine

onready var move_state = $State_Machine/Move


func _unhandled_input(Event: InputEvent):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_state.move_dir = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		state_machine.change_state(move_state)
