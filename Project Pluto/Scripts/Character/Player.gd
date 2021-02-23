class_name Player
extends Character


signal update_health(health)
signal update_stamina(stamina)
signal update_current_weapon(weapon)
signal update_keys(keys)


const DEATH_SCENE = 'res://Scenes/Menu/GameOver.tscn'

var num_keys: int = 0

onready var interact_state: InteractState = $StateMachine/Interact as InteractState
onready var dodge_state: DodgeState = $StateMachine/Dodge as DodgeState
onready var special_state: SpecialState = $StateMachine/SpecialAttack as SpecialState

onready var weapon_slots: Node2D = $Sprite/FacingPivot/Weapons as Node2D

export var max_weapon_count: int = 2


func _ready() -> void:
	animation_tree.active = true

# Handles all user input to control the player
func _unhandled_input(_event: InputEvent) -> void:
	var input_vector: Vector2 = Vector2(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	)
	move_state.move_dir = input_vector
	dodge_state.dodge_dir = input_vector
	
	# Updating state
	if state_machine.can_change_state:
		var mouse_position = get_local_mouse_position().normalized()
		set_face_dir(mouse_position)
		special_state.attack_dir = mouse_position
		
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
			
		elif Input.is_action_just_pressed('swap_weapon'):
			get_next_weapon()
			
		elif input_vector != Vector2.ZERO: # Checking if move button is pushed
			play_animation('move')
			state_machine.change_state(move_state)
			
		else:
			play_animation('idle')


func add_weapon(value: Weapon) -> void:
	# Dropping current weapon if too many are held
	if weapon_slots.get_child_count() >= max_weapon_count:
		drop_weapon(weapon)
		
	set_weapon(value)
	weapon.visible = false
	
	weapon.get_parent().remove_child(weapon)
	weapon_slots.add_child(weapon)

func get_next_weapon() -> void:
	var num_weapons: int = weapon_slots.get_child_count()

	if num_weapons > 1:
		var cur_weapon_index: int = weapon.get_index()
		if cur_weapon_index == num_weapons - 1:
			set_weapon(weapon_slots.get_child(0) as Weapon)
		else:
			set_weapon(weapon_slots.get_child(cur_weapon_index + 1) as Weapon)


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

func set_weapon(value: Weapon) -> void:
	.set_weapon(value)
	
	special_state.weapon = weapon
	emit_signal('update_current_weapon', weapon)


func _on_state_completed() -> void:
	state_machine.change_state(move_state)
	
	if move_state.move_dir == Vector2.ZERO:
		play_animation('idle')
	else:
		#set_face_dir(move_state.move_dir)
		play_animation('move')
