extends KinematicBody2D


onready var state_machine: Node = $StateMachine
onready var move_state: Node = $StateMachine/Move
onready var attack_state: Node = $StateMachine/Attack


func _ready() -> void:
	attack_state.weapon = $Weapons/Weapon as Weapon

func _unhandled_input(_event: InputEvent) -> void:
	var input_vector: Vector2 = Vector2(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	)
	move_state.move_dir = input_vector.normalized()
	
	# Updating state
	if Input.is_action_just_pressed('attack'):
		state_machine.change_state(attack_state)
		
	elif input_vector != Vector2.ZERO: # Checking if move button is pushed
		state_machine.change_state(move_state)
