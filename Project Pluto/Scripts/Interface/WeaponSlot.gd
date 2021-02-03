class_name WeaponSlot
extends Sprite


var weapon: Weapon setget _set_weapon
var weapon_sprite: Sprite


func _set_weapon(value: Weapon) -> void:
	if weapon_sprite != null:
		weapon_sprite.queue_free()
		
	weapon_sprite = value.duplicate()
	weapon_sprite.position = Vector2.ZERO
	weapon_sprite.rotation = 0
	weapon_sprite.visible = true
	weapon_sprite.scale = weapon_sprite.scale * Vector2(1 / scale.x, 1 / scale.y)
	
	add_child(weapon_sprite)
