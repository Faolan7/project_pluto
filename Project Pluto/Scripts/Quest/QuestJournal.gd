extends Node


var QUEST_SCENE = load('res://Scripts/Quest/Quest.gd')

var quests: Dictionary = {}


func register_quest(quest_name: String, tasks: Array) -> Quest:
	if not quest_name in quests:
		var quest: Quest = QUEST_SCENE.new() as Quest
		quests[quest_name] = quest
		
		quest.init(tasks)
		
	return quests[quest_name]

func add_kill(enemyID) -> void:
	for quest in quests.values():
		if quest.state == quest.QuestState.STARTED:
			quest.tasks[0].add_kill(enemyID)
