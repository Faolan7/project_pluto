class_name DroppedWeapon
extends InteractBox


var weapon: Weapon setget set_weapon
var weapon_data: Dictionary


func _ready() -> void:
	var last_child: Node = get_child(get_child_count() - 1)
	if last_child is Weapon:
		set_weapon(last_child)


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


func set_weapon(value: Weapon) -> void:
	weapon = value
	weapon_data['position'] = weapon.position
	weapon_data['rotation'] = weapon.rotation
	
	weapon.position = Vector2.ZERO
	weapon.rotation = 0

func get_weapon() -> Weapon:
	weapon.position = weapon_data['position']
	weapon.rotation = weapon_data['rotation']
	return weapon
