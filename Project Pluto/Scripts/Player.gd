extends KinematicBody2D


onready var state_machine: Node = $StateMachine
onready var move_state: Node = $StateMachine/Move


func _unhandled_input(_event: InputEvent) -> void:
	var input_vector: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	move_state.move_dir = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		state_machine.change_state(move_state)
