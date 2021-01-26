class_name Projectile
extends Sprite


var wielder: Node2D setget set_wielder, get_wielder
var velocity: Vector2

onready var hitbox: Hitbox = $Hitbox as Hitbox


func _physics_process(delta: float) -> void:
	position += velocity * delta


func set_wielder(value: Node2D) -> void:
	hitbox.wielder = value

func get_wielder() -> Node2D:
	return hitbox.wielder as Node2D


func _on_collision(collision_object: CollisionObject2D) -> void:
	if collision_object != get_wielder():
		queue_free()
