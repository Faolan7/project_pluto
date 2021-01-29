extends Node2D


const DIALOGUE: Resource = preload('res://Scenes/Interface/Dialogue.tscn')

var player: Player setget set_player

onready var player_bars: PlayerBars = $PlayerBars as PlayerBars
onready var weapon_slot: WeaponSlot = $WeaponSlots/WeaponSlot as WeaponSlot


func create_dialogue(speaker: Object, callback: String, text: String) -> void:
	var dialogue: DialogueBox = DIALOGUE.instance() as DialogueBox
	add_child(dialogue)
	# warning-ignore:return_value_discarded
	dialogue.connect('closed', self, 'remove_child', [dialogue])
	# warning-ignore:return_value_discarded
	dialogue.connect('closed', speaker, callback)
	
	dialogue.display_text(text)


func set_player(value: Player) -> void:
	player = value
	
	player_bars.set_bar_values(player)
	
	# warning-ignore:return_value_discarded
	player.connect('update_health', player_bars, '_on_hp_update')
	# warning-ignore:return_value_discarded
	player.connect('update_stamina', player_bars, '_on_stamina_update')
	# warning-ignore:return_value_discarded
	player.connect("update_current_weapon", self, "_on_update_current_weapon")


func _on_update_current_weapon(weapon) -> void:
	weapon_slot.weapon = weapon
