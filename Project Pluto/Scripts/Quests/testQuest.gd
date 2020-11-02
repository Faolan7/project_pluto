extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var quest_journal = $Quest_Journal

# Called when the node enters the scene tree for the first time.
func _ready():
	quest_journal.add_quest("ahab","ahabs ahab",1,1)
	quest_journal.check_for_enemy_in_journal(1)

#Create an unhandledinput method that can be used for testing using buttons, and give the scene time to load
#func _unhandled_input(_event: InputEvent) -> void:
#
#	# Updating state
#	if Input.is_action_just_pressed('attack'):
#		questNode.condition.addToTheBodyCount(1)
#		if(questNode.condition.checkForCompletion()):
#			questNode.reward.quest_completed()
