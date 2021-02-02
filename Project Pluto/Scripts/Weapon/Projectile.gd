class_name Projectile
extends Sprite


var entity: PhysicsBody2D setget set_entity, get_entity
var velocity: Vector2

onready var hitbox: Hitbox = $Hitbox as Hitbox


func _physics_process(delta: float) -> void:
	position += velocity * delta


func set_entity(value: PhysicsBody2D) -> void:
	hitbox.entity = value

func get_entity() -> PhysicsBody2D:
	return hitbox.entity as PhysicsBody2D


func _on_collision(collision_object: CollisionObject2D) -> void:
	if collision_object != get_entity():
		queue_free()
