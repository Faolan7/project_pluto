class_name Player
extends KinematicBody2D


var face_dir: Vector2 = Vector2.RIGHT setget set_face_dir

onready var animation_tree: AnimationTree = $AnimationTree as AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var facing_pivot: Node2D = $Sprite/FacingPivot as Node2D
onready var state_machine: StateMachine = $StateMachine as StateMachine
onready var move_state: State = $StateMachine/Move as State
onready var attack_state: State = $StateMachine/Attack as State
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
	move_state.move_dir = input_vector.normalized()
	set_face_dir(input_vector)
	
	# Updating state
	if state_machine.can_change_state:
		if Input.is_action_just_pressed('attack'):
			state_machine.change_state(attack_state)
			
		elif Input.is_action_just_pressed('interact'):
			state_machine.change_state(interact_state)
			
		elif input_vector != Vector2.ZERO: # Checking if move button is pushed
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

# Player interacts with the weapon (Assuming we only have one weapon) -> PROOF OF CONCEPT
func add_weapon(passed_weapon: Weapon) -> void:
	passed_weapon.visible = false
	weapon_slots.add_child(passed_weapon)


# Player interacting with a weapon on the ground (Assuming we have weapon inventory set up) -> more generic
# 	Check to see if we have a "full inventory"
# 	if we have a full inventory:
#		"Pop" a weapon off the stack
#		Drop weapon on the ground as a "DroppedItem"
#	Get a pointer that points to the "Weapons" Node
#	Recieve a signal from "DroppedItem" that would send the "Weapon" child to this script
#	Add the recieved "Weapon" as a child of the "Weapons" Node
#	Emit signal back to the "DroppedItem" that would delete the "DroppedItem" from the scene
#	Insert Interaction shinanigans here because I don't understand how it fully works.
