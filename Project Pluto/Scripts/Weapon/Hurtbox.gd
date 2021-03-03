class_name HurtBox
extends Area2D


signal damaged(damage, dealer)


onready var entity: PhysicsBody2D = get_parent() as PhysicsBody2D


func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox and area.entity != entity and is_instance_valid(area.entity):
		var hitbox: Hitbox = area as Hitbox
		
		emit_signal('damaged',
			hitbox.damage * hitbox.entity.damage_multiplier,
			hitbox.entity)
