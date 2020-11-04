# Create a singleton variable named ENEMY_TABLE
# This singleton will be a hash-table esque thing where there will have:
#	<Key that will be able to be looked at for easy lookup, Monster Information
#	<Monster_ID, new Monster(name: String, starting_weapon:Weapon, reward:Reward)>
#	This singleton assumes: 
#		we have some form of class for Monster
#		we have some form of class for Weapon
#		we have some form of class for Reward

# homework: Look into enumerations for Godot. This could
#		   Make this easier with comparisons

# NPC Dialogue:
#	We can use a Dictionary to house the NPCs dialogue that will be
#	relative to each NPC. This would mean that Bart the Barber will only
#	give you things about haircuts, and Sally the Blacksmith will only talk
#	about dropping her hammer on things. This means that each NPC will house
#	their own components necessary for dialogue

# Quest Dialogue:
#	We use the same dictionary thing from the NPCs but instead apply it
#	On a Quest by Quest basis. When the dialogue for the quest is exhausted
#	it will emit a signal that will tell the NPC to not pull up that dialogue
#	from the quest associated with the NPC

#	You would want something in the NPC dialogue being 'quest_being_undertaken'
#	that would have the NPC ask "Hey, how is that quest coming along?"
#	and we have something else that is 'quest_is_completed.' and the NPC
#	would pull a graditude type response upon completion. 

#	quest_status_code: int = 0, 1, or 2
#		0 - the player has not accepted the quest
#		1 - the player has not completed the quest
#		2 - the player has completed the quest

# Dialogue Dictionary Idea:
#	This would be a massive lookup table that would house a <key, value> 
#	System. The key would be the ID associated with the NPC in question
#	The value would be a Dictionary that would be filled with responses 
#	for everything that the NPC could say. 
