extends Node

var npc: String
var quest_name: String
onready var condition = $Condition
onready var reward = $Reward


signal quest_completed(xp, gold, items)

#similar to constructor. please dont use the holy flamer matt
func set_quest(passed_npc: String, passed_quest_name: String, enemyID: int, numOfEnemy: int, rewards: Array) -> void:
	
	npc = passed_npc
	quest_name = passed_quest_name
	condition.create_conditions(enemyID, numOfEnemy)
	reward.create_reward(rewards[0], rewards[1], rewards[2])

func _on_Condition_conditions_met():
	emit_signal("quest_completed")
