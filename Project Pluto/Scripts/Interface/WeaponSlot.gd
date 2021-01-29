class_name WeaponSlot
extends Sprite


var weapon: Weapon setget _set_weapon

onready var weapon_sprite: Sprite = $WeaponSprite as Sprite


func _set_weapon(value: Weapon) -> void:
	weapon_sprite.texture = value.texture
	weapon_sprite.modulate = value.modulate
	weapon_sprite.self_modulate = value.self_modulate
