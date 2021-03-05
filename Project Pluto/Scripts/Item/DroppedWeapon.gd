class_name DroppedWeapon
extends InteractBox


var weapon: Weapon setget set_weapon
var weapon_data: Dictionary
var is_enemy_weapon: bool = false


func _ready() -> void:
	var last_child: Node = get_child(get_child_count() - 1)
	if last_child is Weapon:
		set_weapon(last_child)


static func init(drop_pos: Vector2, drop_weapon: Weapon) -> DroppedWeapon:
	var instance: DroppedWeapon = load("res://Scenes/Item/DroppedWeapon.tscn").instance() as DroppedWeapon
	instance.position = drop_pos
	
	drop_weapon.get_parent().remove_child(drop_weapon)
	instance.add_child(drop_weapon)
	
	return instance

func interact(player):
	.interact(player)
	player.add_weapon(get_weapon())
	
	finish_interaction(true)


func set_weapon(value: Weapon) -> void:
	weapon = value
	weapon_data['position'] = weapon.position
	weapon_data['rotation'] = weapon.rotation
	print('set: ', weapon_data)
	
	is_enemy_weapon = weapon.entity != null and weapon.entity.is_class('Enemy')
	weapon.position = Vector2.ZERO
	weapon.rotation = 0
	weapon.visible = true
	weapon.set_entity(null)
	weapon.set_hitbox_enabled(false, false)
	weapon.set_hitbox_enabled(false, true)

func get_weapon() -> Weapon:
	print(weapon_data)
	weapon.position = weapon_data['position']
	weapon.rotation = weapon_data['rotation']
	return weapon
