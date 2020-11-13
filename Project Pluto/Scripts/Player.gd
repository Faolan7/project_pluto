class_name Player
extends KinematicBody2D


var face_dir: Vector2 = Vector2.RIGHT setget set_face_dir

onready var animation_tree: AnimationTree = $AnimationTree as AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var facing_pivot: Node2D = $Sprite/FacingPivot as Node2D
onready var state_machine: StateMachine = $StateMachine as StateMachine
onready var move_state: State = $StateMachine/Move as State
onready var attack_state: State = $StateMachine/Attack as State


func _ready() -> void:
	animation_tree.active = true
	
	attack_state.weapon = $Sprite/FacingPivot/Weapons/Weapon as Weapon

func _unhandled_input(_event: InputEvent) -> void:
	var input_vector: Vector2 = Vector2(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	)
	move_state.move_dir = input_vector.normalized()
	set_face_dir(input_vector)
	
	# Updating state
	if Input.is_action_just_pressed('attack'):
		state_machine.change_state(attack_state)
		
	elif input_vector != Vector2.ZERO: # Checking if move button is pushed
		animation_state.travel("Run")
		state_machine.change_state(move_state)
		
	else:
		animation_state.travel("Idle")


func set_face_dir(value: Vector2):
	if abs(face_dir.angle_to(value)) > PI / 3:
		face_dir = value.snapped(Vector2(1, 1))
		
		animation_tree.set("parameters/Idle/blend_position", face_dir)
		animation_tree.set("parameters/Run/blend_position", face_dir)
		
		facing_pivot.rotation = face_dir.angle()
		facing_pivot.show_behind_parent = face_dir == Vector2.UP
