extends PanelContainer

onready var label = $Label

func display_text(dialogue: String):
	label.text = dialogue
	visible = true

func _input(_event: InputEvent):
	if Input.is_action_just_pressed('interact'):
		visible = false
		accept_event()
