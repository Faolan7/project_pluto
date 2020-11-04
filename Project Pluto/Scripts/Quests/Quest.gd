extends Node

var npc: String setget set_npc, get_npc
var quest_name: String setget set_quest_name, get_quest_name
onready var condition = $Condition
onready var reward = $Reward


signal quest_completed

#similar to constructor. please dont use the holy flamer matt
func set_quest(passed_npc: String, passed_quest_name: String, enemyID: int, numOfEnemy: int) -> void:
	
	set_npc(passed_npc)
	set_quest_name(passed_quest_name)
	set_conditions(enemyID, numOfEnemy)
	#set_reward()
func set_npc(name: String) -> void:
	npc = name

func get_npc() -> String:
	return npc

func set_quest_name(name: String) -> void:
	quest_name = name

func get_quest_name() -> String:
	return quest_name

func set_conditions(enemyID: int, numOfEnemy: int) -> void:
	condition.create_conditions(enemyID, numOfEnemy)



#func set_reward() -> void:
#	reward = Reward.init()




func _on_Condition_conditions_met():
	emit_signal("quest_completed")
