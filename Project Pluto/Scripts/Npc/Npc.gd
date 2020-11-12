extends KinematicBody2D


var quest

onready var interact_box: Area2D = $InteractBox


func _ready():
	quest = QuestJournal.register_quest(1, 1, [0, 0, []])


func _on_interaction():
	if quest.state == quest.QuestState.UNSTARTED:
		quest.state = quest.QuestState.STARTED
		var dialogue = UI.create_dialogue('Yo! Get dat dude, dude!')
		dialogue.connect('closed', self, '_on_dialogue_closed')
		
	elif quest.state == quest.QuestState.COMPLETED:
		quest.state = quest.QuestState.TURNED_IN
		get_tree().quit()

func _on_dialogue_closed():
	interact_box.emit_signal('interaction_finished')
