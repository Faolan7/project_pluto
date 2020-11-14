extends Node


const QUEST_SCENE = preload('res://Scenes/Quest/Quest.tscn')


func register_quest(enemyID: int, numOfEnemy: int, reward_data: Array) -> Quest:
	var quest: Quest = QUEST_SCENE.instance() as Quest
	add_child(quest)
	
	quest.init(enemyID, numOfEnemy, reward_data)
	
	return quest


func add_kill(enemyID) -> void:
	for quest in get_children():
		quest.tasks[0].add_kill(enemyID)
