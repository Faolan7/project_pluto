class_name Player
extends Character


onready var animation_tree: AnimationTree = $AnimationTree as AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

onready var interact_state: State = $StateMachine/Interact as State

onready var weapon_slots: Node2D = $Sprite/FacingPivot/Weapons as Node2D


func _ready() -> void:
	animation_tree.active = true
	
	attack_state.weapon = $Sprite/FacingPivot/Weapons/Weapon as Weapon

func _unhandled_input(_event: InputEvent) -> void:
	var input_vector: Vector2 = Vector2(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	)
	move_state.move_dir = input_vector
	
	# Updating state
	if state_machine.can_change_state:
		set_face_dir(input_vector)
		
		if Input.is_action_just_pressed('attack'):
			animation_state.travel('idle')
			state_machine.change_state(attack_state)
			
		elif Input.is_action_just_pressed('interact'):
			animation_state.travel('idle')
			state_machine.change_state(interact_state)
			
		elif input_vector != Vector2.ZERO: # Checking if move button is pushed
			animation_state.travel('move')
			state_machine.change_state(move_state)
			
		else:
			animation_state.travel('idle')


func add_weapon(weapon: Weapon) -> void:
	weapon.visible = false
	
	weapon.get_parent().remove_child(weapon)
	weapon_slots.add_child(weapon)


func set_face_dir(value: Vector2) -> void:
	.set_face_dir(value)
	set_blend_position(face_dir)

func set_blend_position(value: Vector2) -> void:
	animation_tree.set('parameters/idle/blend_position', value)
	animation_tree.set('parameters/move/blend_position', value)


func _on_state_completed() -> void:
	state_machine.change_state(move_state)
	
	set_face_dir(move_state.move_dir)
	if move_state.move_dir == Vector2.ZERO:
		animation_state.travel('idle')
	else:
		animation_state.travel('move')
