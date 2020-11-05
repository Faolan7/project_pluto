class_name Condition
extends Node

onready var ENEMY_ID: int
onready var number_to_kill: int
onready var number_killed: int

signal conditions_met


func create_conditions(enemy_ID: int, number_of_enemies: int) -> void:
	ENEMY_ID = enemy_ID
	number_to_kill = number_of_enemies


func add_to_the_body_count(enemy_ID: int) -> void:
	if(enemy_ID == ENEMY_ID):
		number_killed += 1
		check_for_completion()


func check_for_completion() -> void:
	if number_to_kill == number_killed:
		emit_signal("conditions_met")
