class_name DroppedWeapon
extends InteractBox


var weapon: Weapon setget set_weapon, get_weapon
var weapon_data: Dictionary

export(NodePath) var INITIAL_WEAPON_NODE: NodePath


func _ready() -> void:
	if weapon == null:
		set_weapon(get_node(INITIAL_WEAPON_NODE))


func init(drop_pos: Vector2, drop_weapon: Weapon) -> void:
	position = drop_pos
	set_weapon(drop_weapon)
	weapon.visible = true
	weapon.set_wielder(null)
	
	weapon.get_parent().remove_child(weapon)
	add_child(weapon)

func interact(player):
	.interact(player)
	player.add_weapon(get_weapon())
	
	finish_interaction()
	queue_free()

#Broken when bow is put into the DroppedWeapon
#Parameter passed in is NULL
func set_weapon(value: Weapon) -> void:
	print(value)
	weapon = value
	weapon_data['position'] = weapon.position
	weapon_data['rotation'] = weapon.rotation
	weapon.position = Vector2.ZERO
	weapon.rotation = 0
	print("did we make it?")


func get_weapon() -> Weapon:
	weapon.position = weapon_data['position']
	weapon.rotation = weapon_data['rotation']
	return weapon
