class_name Projectile
extends Hitbox


var velocity: Vector2


func _physics_process(delta: float) -> void:
	position += velocity * delta


func _on_collision(hurtbox: HurtBox) -> void:
	# hurtbox is null if the projectile collided with something other than a HurtBox
	if hurtbox == null or hurtbox.entity != entity:
		queue_free()
