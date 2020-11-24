class_name Weapon
extends Sprite

signal attack_finished
signal attack_range_entered

onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
onready var hitbox: Hitbox = $Hitbox as Hitbox
onready var attack_range: Area2D = $AttackRange as Area2D

var wielder: KinematicBody2D setget set_wielder, get_wielder

func use() -> void:
	animation_player.play('stab')


func _on_animation_finished(_anim_name: String) -> void:
	emit_signal('attack_finished')

func _on_attack_range_entered(_body: PhysicsBody2D) -> void:
	emit_signal('attack_range_entered')


func set_wielder(value: KinematicBody2D) -> void:
	hitbox.wielder = value

func get_wielder() -> KinematicBody2D:
	return hitbox.wielder

func has_targets_in_range() -> bool:
	for body in attack_range.get_overlapping_bodies():
		if body != get_wielder():
			return true
	return false
