extends Control

const DIALOGUE: Resource = preload('res://Scenes/Npc/Dialogue.tscn')


func create_dialogue(speaker: Object, callback: String, text: String) -> void:
	var dialogue: DialogueBox = DIALOGUE.instance() as DialogueBox
	add_child(dialogue)
	# warning-ignore:return_value_discarded
	dialogue.connect('closed', self, 'remove_child', [dialogue])
	# warning-ignore:return_value_discarded
	dialogue.connect('closed', speaker, callback)
	
	dialogue.display_text(text)
