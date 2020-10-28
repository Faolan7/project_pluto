class_name Condition
extends Node

onready var ENEMY: int
onready var NumberOf: int
onready var ActuallyDead: int

signal conditions_met

func _init(enemyID: int, numberOfBeDead: int) -> void:
	ENEMY = enemyID # for quick look up to be sure this is the correct enemy
	NumberOf = numberOfBeDead


func checkForCompletion():
	if(NumberOf == ActuallyDead):
		emit_signal("conditions_met")

#This could increment only if the enemy ID was the same.
func addToTheBodyCount(enemyID: int) -> void:
	if(enemyID == ENEMY):
		ActuallyDead = ActuallyDead + 1
