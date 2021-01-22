extends Sprite

var wielder: Node2D setget set_wielder, get_wielder
onready var hitbox: Hitbox = $Hitbox as Hitbox
var velocity
onready var get_attack_range = get_parent() #$AttackRange/CollisionShape2D


func set_wielder(value: Node2D) -> void:
	hitbox.wielder = value

func get_wielder() -> Node2D:
	return hitbox.wielder as Node2D


func _physics_process(delta):
	position += velocity *  delta


func _on_Hitbox_body_entered(body):
	if body != get_wielder():
		queue_free()
