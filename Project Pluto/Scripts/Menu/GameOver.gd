extends Node


onready var background: AnimatedSprite = get_node('.') as AnimatedSprite


func _ready() -> void:
	background.playing = true


func _on_continue_pressed() -> void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene('res://Scenes/Dungeon/Dungeon.tscn')

func _on_exit_pressed() -> void:
	get_tree().quit()
