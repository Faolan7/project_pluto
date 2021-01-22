class_name Weapon
extends Sprite


signal attack_finished
signal attack_range_entered


var wielder: Node2D setget set_wielder, get_wielder

onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
onready var hitbox: Hitbox = $Hitbox as Hitbox
onready var attack_range: Area2D = $AttackRange as Area2D

export(float) var attack_stamina_cost: float


func use() -> void:
	animation_player.play('stab')

func has_targets_in_range() -> bool:
	for area in attack_range.get_overlapping_areas():
		if area.get_parent() != get_wielder():
			return true
	return false


func set_wielder(value: Node2D) -> void:
	hitbox.wielder = value

func get_wielder() -> Node2D:
	return hitbox.wielder as Node2D


func _on_animation_finished(_anim_name: String) -> void:
	emit_signal('attack_finished')

func _on_attack_range_entered(area: Area2D) -> void:
	if area.get_parent() != get_wielder():
		emit_signal('attack_range_entered')
