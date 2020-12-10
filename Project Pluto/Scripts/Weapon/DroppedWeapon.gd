class_name DroppedWeapon
extends InteractBox


var weapon: Weapon

export(NodePath) var INITIAL_WEAPON_NODE: NodePath


func _ready() -> void:
	if weapon == null:
		weapon = get_node(INITIAL_WEAPON_NODE)

func init(drop_pos: Vector2, drop_weapon: Weapon) -> void:
	position = drop_pos
	weapon = drop_weapon
	
	weapon.get_parent().remove_child(weapon)
	add_child(weapon)
	
	weapon.visible = true
	weapon.position = Vector2.ZERO
	weapon.rotation = 0
	weapon.set_wielder(null)

func interact(player):
	.interact(player)
	
	player.add_weapon(weapon)
	
	finish_interaction()
	queue_free()
