extends Projectile


onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
onready var explosion_hitbox: Hitbox = $Explosion/ExplosionHitbox as Hitbox


func set_entity(value: PhysicsBody2D) -> void:
	.set_entity(value)
	explosion_hitbox.entity = entity


func _on_collision(hurtbox: HurtBox) -> void:
	# hurtbox is null if the projectile collided with something other than a HurtBox
	if hurtbox == null or hurtbox.entity != entity:
		velocity = Vector2.ZERO
		set_physics_process(false)
		
		animation_player.play('explode')

func _on_animation_finished(_anim_name: String):
	queue_free()
