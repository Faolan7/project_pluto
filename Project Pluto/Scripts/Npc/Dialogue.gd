class_name DialogueBox
extends PanelContainer

signal closed


onready var label = $Label


func _input(_event: InputEvent):
	if Input.is_action_just_pressed('interact'):
		visible = false
		accept_event()
		
		emit_signal('closed')


func display_text(dialogue: String):
	label.text = dialogue
	visible = true
