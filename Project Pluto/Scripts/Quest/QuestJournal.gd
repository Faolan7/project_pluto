extends Node


var quests: Dictionary = {}


func register_quest(quest_name: String, tasks: Array) -> Quest:
	if not quest_name in quests:
		quests[quest_name] = Quest.init(tasks)
		
	return quests[quest_name]

func add_kill(enemyID) -> void:
	for quest in quests.values():
		if quest.state == quest.QuestState.STARTED:
			quest.tasks[0].add_kill(enemyID)
