class_name Player
extends Character


signal update_health(health)
signal update_stamina(stamina)
signal update_current_weapon(weapon)
signal update_keys(keys)


const DEATH_SCENE = 'res://Scenes/Menu/GameOver.tscn'

var num_keys: int = 0
var using_gamepad: bool = false
var last_mouse_position: Vector2 

onready var interact_state: State = $StateMachine/Interact as State
onready var dodge_state: State = $StateMachine/Dodge as State
onready var special_state: State = $StateMachine/SpecialAttack as State

onready var weapon_slots: Node2D = $Sprite/FacingPivot/Weapons as Node2D

export var max_weapon_count: int = 1


func _ready() -> void:
	animation_tree.active = true

# Handles all user input to control the player
func _unhandled_input(_event: InputEvent) -> void:
	var input_vector: Vector2 = Vector2(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	)
	move_state.move_dir = input_vector
	dodge_state.dodge_dir = input_vector if input_vector != Vector2.ZERO else face_dir
	
	# Updating state
	if state_machine.can_change_state:
		set_face_dir(Vector2.ZERO)
		
		if Input.is_action_just_pressed('attack') and attack_state.weapon != null:
			play_animation('idle')
			state_machine.change_state(attack_state)
			
		elif Input.is_action_just_pressed('attack_special') and special_state.weapon != null:
			state_machine.change_state(special_state)
			
		elif Input.is_action_just_pressed('interact'):
			play_animation('idle')
			state_machine.change_state(interact_state)
			emit_signal('update_keys', num_keys)
			
		elif Input.is_action_just_pressed('dodge'):
			state_machine.change_state(dodge_state)
			
		elif input_vector != Vector2.ZERO: # Checking if move button is pushed
			play_animation('move')
			state_machine.change_state(move_state)
			
		else:
			play_animation('idle')


func add_weapon(weapon: Weapon) -> void:
	if weapon_slots.get_child_count() >= max_weapon_count:
		drop_weapon(attack_state.weapon)
		
	weapon.visible = false
	attack_state.weapon = weapon
	special_state.weapon = weapon
	emit_signal('update_current_weapon', weapon)
	
	weapon.get_parent().remove_child(weapon)
	weapon_slots.add_child(weapon)


func set_health(value: float) -> void:
	.set_health(value)
	emit_signal('update_health', get_health())
	
	if get_health() <= 0:
		# warning-ignore:return_value_discarded
		get_tree().change_scene(DEATH_SCENE)

func set_stamina(value: float) -> void:
	.set_stamina(value)
	emit_signal('update_stamina', get_stamina())

func set_blend_position(value: Vector2) -> void:
	.set_blend_position(value)
	animation_tree.set('parameters/dodge/blend_position', dodge_state.dodge_dir)

func set_face_dir(_value: Vector2) -> void:
	var gamepad_dir: Vector2 = Vector2(
		Input.get_action_strength('look_right') - Input.get_action_strength('look_left'),
		Input.get_action_strength('look_down') - Input.get_action_strength('look_up')
	)
	var mouse_position: Vector2 = get_global_mouse_position()
	
	if last_mouse_position != mouse_position:
		using_gamepad = false
	elif gamepad_dir != Vector2.ZERO:
		using_gamepad = true
	elif using_gamepad and gamepad_dir == Vector2.ZERO:
		return
		
	last_mouse_position = mouse_position
	.set_face_dir(gamepad_dir if using_gamepad else mouse_position - position)
	special_state.attack_dir = face_dir

func _on_state_completed() -> void:
	state_machine.change_state(move_state)
	
	if move_state.move_dir == Vector2.ZERO:
		play_animation('idle')
	else:
		#set_face_dir(move_state.move_dir)
		play_animation('move')
