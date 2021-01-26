class_name MeleeWeapon
extends Weapon


onready var hitbox: Hitbox = $Hitbox as Hitbox


func set_wielder(value: Node2D) -> void:
	.set_wielder(value)
	hitbox.wielder = value
