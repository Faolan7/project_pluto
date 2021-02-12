class_name Weapon
extends Sprite


signal attack_finished
signal special_finished
signal attack_range_entered


var entity: Node2D setget set_entity, get_entity

onready var attack_range: Area2D = $AttackRange as Area2D
onready var attack_range_shape: CollisionShape2D = $AttackRange/CollisionShape2D as CollisionShape2D
onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
onready var tween: Tween = $Tween as Tween

export(String) var attack_name: String
export(float) var attack_stamina_cost: float
export(String) var special_name: String
export(float) var special_stamina_cost: float


func use(_attack_dir: float) -> void:
	Attacks.perform(attack_name, self)

func use_special(_attack_dir: float) -> void:
	Attacks.perform(special_name, self)


func set_entity(value: PhysicsBody2D):
	entity = value
	attack_range_shape.set_deferred('disabled', value == null or not value.is_class('Enemy'))

func get_entity():
	return entity

func has_entity_in_range(target) -> bool: # Target should be Character
	return attack_range.get_overlapping_areas().has(target.hurtbox)


func _on_animation_finished(anim_name: String) -> void:
	match anim_name:
		'attack': emit_signal('attack_finished')
		'special': emit_signal('special_finished')

func _on_attack_range_entered(area: Area2D) -> void:
	if area.get_parent() != entity:
		emit_signal('attack_range_entered')
