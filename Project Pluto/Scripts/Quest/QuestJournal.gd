extends Node


const QUEST_SCENE = preload('res://Scenes/Quest/Quest.tscn')


func register_quest(enemyID: int, numOfEnemy: int, reward_data: Array):
	var quest = QUEST_SCENE.instance()
	add_child(quest)
	
	quest.init(enemyID, numOfEnemy, reward_data)
	
	return quest


func check_for_enemy_in_journal(enemy_ID) -> void:
	for i in get_children():
		i.tasks[0].add_kill(enemy_ID)
