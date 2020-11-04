extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var quest_journal = $Quest_Journal

# Called when the node enters the scene tree for the first time.
func _ready():
	quest_journal.add_quest("ahab","ahabs ahab",1,1, [100,100,["Ignore the man behind the curtain"]])
#	quest_journal.check_for_enemy_in_journal(1)

#Create an unhandledinput method that can be used for testing using buttons, and give the scene time to load
func _unhandled_input(_event: InputEvent) -> void:

# Updating state
	if Input.is_action_just_pressed('attack'):
		quest_journal.check_for_enemy_in_journal(1)


#this function is called when a signal is emited from the journal, which
#then displays the rewards of the quest
func _on_Quest_Journal_display_rewards_on_screen(xp, gold, items):
	var displayed_string = "XP: " + xp as String + "\nGold: " + gold as String+ "\nItems: " + items as String
	self.get_child(1).get_child(0).add_text(displayed_string)
