extends KinematicBody2D


var quest: Quest

onready var interact_box: InteractBox = $InteractBox as InteractBox


func _ready():
	quest = QuestJournal.register_quest('Tutorial Quest', [{
		'type': 'kill',
		'enemy': 1,
		'quantity': 1
	}])


func _on_interaction(_player: Player) -> void:
	match quest.state:
		Quest.QuestState.UNSTARTED:
			quest.state = Quest.QuestState.STARTED
			UI.create_dialogue(self, '_on_dialogue_closed',
				"Hey! That dummy over there called me a dummy. Go give him a good smackin' for me, dummy.")
				
		Quest.QuestState.COMPLETED:
			quest.state = Quest.QuestState.TURNED_IN
			UI.create_dialogue(self, '_on_dialogue_closed',
				"Wow! I didn't actually think you'd be smart enough to do that, dummy!")
				
		_:
			UI.create_dialogue(self, '_on_dialogue_closed',
				"You just gotta go into that other room, dummy!")

func _on_dialogue_closed() -> void:
	interact_box.finish_interaction()
	
	if quest.state == quest.QuestState.TURNED_IN:
		get_tree().quit()
