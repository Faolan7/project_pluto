extends KinematicBody2D


onready var state_machine: Node = $StateMachine
onready var move_state: Node = $StateMachine/Move
onready var attack_state: Node = $StateMachine/Attack
onready var interact_state: Node = $StateMachine/Interact
# Need a variable that attaches the Quest Journal to the player
# This would need to be kept track of basically 24/7 as wherever the player
# Goes, this object will have to go. If we had a manager that oversaw
# All of the important data that we want kept to be at the ready for any purpose
# this would allow our journal to not be erased a lot.

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
		
	elif Input.is_action_just_pressed('interact'):
		state_machine.change_state(interact_state)
		
	elif input_vector != Vector2.ZERO: # Checking if move button is pushed
		state_machine.change_state(move_state)
