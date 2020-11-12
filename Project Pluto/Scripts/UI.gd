extends Control

const DIALOGUE = preload('res://Scenes/Npc/Dialogue.tscn')


func create_dialogue(text: String) -> DialogueBox:
	var dialogue = DIALOGUE.instance()
	add_child(dialogue)
	dialogue.connect('closed', self, 'remove_child', [dialogue])
	
	dialogue.display_text(text)
	return dialogue
