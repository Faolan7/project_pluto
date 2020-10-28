extends Node

var npc: String setget set_npc, get_npc
var quest_name: String setget set_quest_name, get_quest_name
var conditions: Condition
var reward: Reward



func _init(npc: String, quest_name: String, enemyID: int, numOfEnemy: int):
	pass

func set_npc(name: String) -> void:
	npc = name

func get_npc() -> String:
	return npc

func set_quest_name(name: String) -> void:
	quest_name = name

func get_quest_name() -> String:
	return quest_name

func set_conditions(enemyID: int, numOfEnemy: int) -> void:
	conditions = Condition.init(enemyID, numOfEnemy)

func set_reward() -> void:
	reward = Reward.init()
