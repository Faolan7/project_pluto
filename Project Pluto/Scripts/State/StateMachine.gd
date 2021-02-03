class_name StateMachine
extends Node


var can_change_state: bool setget ,_get_can_change_state
var current_state: State

export(NodePath) var ACTOR_NODE: NodePath


func _ready() -> void:
	var actor: KinematicBody2D = get_node(ACTOR_NODE) as KinematicBody2D
	
	for child in get_children():
		var state: State = child as State
		
		state.deactivate()
		state.actor = actor


func change_state(new_state: State) -> void:
	if current_state != null:
		current_state.deactivate()
		
	current_state = new_state
	current_state.activate()


func _get_can_change_state() -> bool:
	return current_state.is_completed if current_state != null else true
