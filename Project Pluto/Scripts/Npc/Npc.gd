extends KinematicBody2D


var quest: Quest

onready var interact_box: InteractBox = $InteractBox as InteractBox


func _ready():
	quest = QuestJournal.register_quest(1, 1, [0, 0, []])


func _on_interaction() -> void:
	if quest.state == quest.QuestState.UNSTARTED:
		quest.state = quest.QuestState.STARTED
		UI.create_dialogue(self, '_on_dialogue_closed',
			"Hey! That dummy over there called me a dummy. Go give him a good smackin' for me, dummy.")
			
	elif quest.state == quest.QuestState.COMPLETED:
		quest.state = quest.QuestState.TURNED_IN
		UI.create_dialogue(self, '_on_dialogue_closed',
			"Wow! I didn't actually think you'd be smart enough to do that, dummy!")
			
	else:
		UI.create_dialogue(self, '_on_dialogue_closed',
			"You just gotta go over there, dummy!")

func _on_dialogue_closed() -> void:
	interact_box.finish_interaction()
	
	if quest.state == quest.QuestState.TURNED_IN:
		get_tree().quit()
