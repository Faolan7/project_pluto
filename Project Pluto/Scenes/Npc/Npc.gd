extends KinematicBody2D

func interact():
	give_quest()

func give_quest():
	QuestJournal.add_quest('Bob', 'Dummy Killing', 1, 1, [0, 0, []])
