class_name Condition
extends Node

onready var ENEMY: int
onready var NumberOf: int
onready var ActuallyDead: int

#signal conditions_met

#working as intended
func createConditions(enemyID: int, numberOfBeDead: int) -> void:
	ENEMY = enemyID # for quick look up to be sure this is the correct enemy
	NumberOf = numberOfBeDead
	
	print(ENEMY)
	print(NumberOf)


#Working, just need to figure out how to attach signal
func checkForCompletion():
	return NumberOf == ActuallyDead
		#emit_signal("conditions_met")

#This could increment only if the enemy ID was the same.
#Working as intended
func addToTheBodyCount(enemyID: int) -> void:
	if(enemyID == ENEMY):
		ActuallyDead = ActuallyDead + 1
