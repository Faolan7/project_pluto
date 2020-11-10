class_name Weapon
extends Sprite

signal attack_finished


onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer

#Need some kind of stat that determines range
#Need some kind of stat that determines damage (Damage variance based or otherwise)


func use() -> void:
	animation_player.play('stab')


func _on_animation_finished(_anim_name: String) -> void:
	emit_signal('attack_finished')
