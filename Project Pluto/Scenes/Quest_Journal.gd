extends Node2D


#layout the limitations of the journal
#	Max number of Quests
const MAX_NUMBER_OF_QUESTS: int = 5
#	Number of current quests
var current_number_of_quests: int = 0
#	assume that view is set up and functional

#	Creation of The Journal Singleton that will be instantiated within the Player Scene as part of the player
#		We would initialize the value of current quests to 0

#	Add a Quest function
func AddQuest():
	
	var new_quest_node = 
	
	
	
	pass
#		We would first check to see if the player has a full quest log
# 		if yes:	We would emit a signal that says that the log is full

#		Create a Quest Node
#			It would contain the following parameters:
#				NPC Name: This will be something that we can use to determine who gave the player the quest
#				Quest Name: Name of the quest, or we could always use an index number, and look it up as the "Quest Name"
#					Idea: Instead of Quest knowing the quest name, we just use the quest name as the name of the node
#				Conditions of Completion: We have 3 categories of Quest conditions
#					1. Kill things
#					2. Collect/Fetch Things
#					3. Escort Quest
#				Reward upon Completion: We would have The Quest contain a number of rewards ranging from:
#					1. EXP
#					2. Gold
#					3. Weapon
#					4. Permanant Stat Upgrade
#					5. Weapon Upgrade
#					6. Temporary Trinkets (maybe for the room based quests???)
#
#


#	Remove a Quest Function
#		This function would only be called if there was a signal emitted that said "Hey, this quest was completed"
#		Give the player the reward
#		Free up queue using the specific quest node
#		Decrement the total quests
#		update the view
#
#
#
#
#
#
#
#
#
#
#

