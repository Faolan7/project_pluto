class_name MeleeWeapon
extends Weapon


onready var hitbox: Hitbox = $Hitbox as Hitbox
onready var hitbox_shape: CollisionShape2D = $Hitbox/CollisionShape2D as CollisionShape2D


func _ready() -> void:
	# warning-ignore:return_value_discarded
	tween.connect('tween_completed', self, '_on_tween_completed')


func play_tween(object: Object, property: String,
		initial_val, final_val, duration: float,
		trans_type: int = 0, ease_type: int = 2, delay: float = 0) -> void:
	hitbox_shape.disabled = false
	.play_tween(object, property, initial_val, final_val, duration,
		trans_type, ease_type, delay)


func set_entity(value: PhysicsBody2D) -> void:
	.set_entity(value)
	hitbox.entity = value


func _on_tween_completed(_object: Object, _key: NodePath) -> void:
	hitbox_shape.disabled = true
