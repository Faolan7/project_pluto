class_name Weapon
extends Sprite


signal attack_finished
signal special_finished
signal attack_range_entered


var wielder: Node2D setget set_wielder, get_wielder

onready var attack_range: Area2D = $AttackRange as Area2D
onready var attack_range_shape: CollisionShape2D = $AttackRange/CollisionShape2D as CollisionShape2D
onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer

export(float) var attack_stamina_cost: float


func use(_attack_dir: float) -> void:
	animation_player.play('attack')

func use_special(_attack_dir: float) -> void:
	animation_player.play('special')

func has_targets_in_range() -> bool:
	for area in attack_range.get_overlapping_areas():
		if area.get_parent() != wielder:
			return true
	return false


func set_wielder(value: Node2D):
	wielder = value
	attack_range_shape.set_deferred('disabled', value == null or not value.is_class('Enemy'))

func get_wielder():
	return wielder


func _on_animation_finished(anim_name: String) -> void:
	match anim_name:
		'attack': emit_signal('attack_finished')
		'special': emit_signal('special_finished')

func _on_attack_range_entered(area: Area2D) -> void:
	if area.get_parent() != wielder:
		emit_signal('attack_range_entered')
