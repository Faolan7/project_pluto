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


func set_player(player: Player) -> void:
	$Resources.connect_player(player)
	player.connect("update_current_weapon", self, "_on_update_current_weapon")
	
func _on_update_current_weapon(weapon) -> void:
	print("updated weapon")
	$CurrentWeapon.texture = weapon.texture
