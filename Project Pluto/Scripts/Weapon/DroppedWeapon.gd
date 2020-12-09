class_name DroppedWeapon
extends InteractBox


var weapon: Weapon


func init(drop_pos: Vector2, drop_weapon: Weapon) -> void:
	position = drop_pos
	weapon = drop_weapon
	
	weapon.get_parent().remove_child(weapon)
	add_child(weapon)
	
	weapon.visible = true
	weapon.set_wielder(null)

func interact(player: Player):
	.interact(player)
	
	player.add_weapon(weapon)
	
	finish_interaction()
	queue_free()
