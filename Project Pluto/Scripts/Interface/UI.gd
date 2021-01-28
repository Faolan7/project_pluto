extends Node2D


const DIALOGUE: Resource = preload('res://Scenes/Interface/Dialogue.tscn')
onready var player: Player setget set_player


func create_dialogue(speaker: Object, callback: String, text: String) -> void:
	var dialogue: DialogueBox = DIALOGUE.instance() as DialogueBox
	add_child(dialogue)
	# warning-ignore:return_value_discarded
	dialogue.connect('closed', self, 'remove_child', [dialogue])
	# warning-ignore:return_value_discarded
	dialogue.connect('closed', speaker, callback)
	
	dialogue.display_text(text)

#Set player was doing too many things, so i separated stuff
#into smaller functions. This helps with readability.
func set_player(player: Player) -> void:
	connect_player_signals(player)
	$Resources.set_bar_values(player)

func connect_player_signals(player: Player) -> void:
	player.connect('update_health', $Resources, '_on_hp_update')
	player.connect('update_stamina', $Resources, '_on_stamina_update')
	
	player.connect("update_current_weapon", self, "_on_update_current_weapon")


func _on_update_current_weapon(weapon) -> void:
	$CurrentWeapon.texture = weapon.texture
