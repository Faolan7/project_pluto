extends KinematicBody2D


onready var state_machine: Node = $StateMachine
onready var move_state: Node = $StateMachine/Move
onready var attack_state: Node = $StateMachine/Attack

onready var animation_player: Node = $AnimationPlayer
onready var animation_tree: Node = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


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
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_state.travel("Run")
		state_machine.change_state(move_state)
	else:
		animation_state.travel("Idle")
