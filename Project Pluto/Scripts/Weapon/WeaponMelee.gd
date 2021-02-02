class_name MeleeWeapon
extends Weapon


onready var hitbox: Hitbox = $Hitbox as Hitbox


func set_entity(value: PhysicsBody2D) -> void:
	.set_entity(value)
	hitbox.entity = value
