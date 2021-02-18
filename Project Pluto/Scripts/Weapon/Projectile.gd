class_name Projectile
extends Hitbox


var velocity: Vector2


func _physics_process(delta: float) -> void:
	position += velocity * delta


func _on_collision(collision_object: CollisionObject2D) -> void:
	if collision_object != entity:
		queue_free()
