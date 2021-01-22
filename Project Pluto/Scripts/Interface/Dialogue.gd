class_name DialogueBox
extends PanelContainer


signal closed


onready var label: Label = $Label as Label


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed('interact'):
		visible = false
		accept_event()
		
		emit_signal('closed')


func display_text(dialogue: String) -> void:
	label.text = dialogue
	visible = true
