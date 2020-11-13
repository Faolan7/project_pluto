extends KinematicBody2D


onready var state_machine: StateMachine = $StateMachine as StateMachine
onready var move_state: State = $StateMachine/Move as State
onready var attack_state: State = $StateMachine/Attack as State
onready var interact_state: State = $StateMachine/Interact as State


func _ready() -> void:
	attack_state.weapon = $Weapons/Weapon as Weapon

func _unhandled_input(_event: InputEvent) -> void:
	var input_vector: Vector2 = Vector2(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	)
	move_state.move_dir = input_vector.normalized()
	
	# Updating state
	if state_machine.can_change_state:
		if Input.is_action_just_pressed('attack'):
			state_machine.change_state(attack_state)
			
		elif Input.is_action_just_pressed('interact'):
			state_machine.change_state(interact_state)
			
		elif input_vector != Vector2.ZERO: # Checking if move button is pushed
			state_machine.change_state(move_state)
