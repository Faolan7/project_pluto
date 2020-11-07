extends KinematicBody2D


var quest


func _ready():
	quest = QuestJournal.register_quest(1, 1, [0, 0, []])

func interact():
	if quest.state == quest.QuestState.UNSTARTED:
		quest.state = quest.QuestState.STARTED
	elif quest.state == quest.QuestState.COMPLETED:
		quest.state = quest.QuestState.TURNED_IN
		get_tree().quit()
