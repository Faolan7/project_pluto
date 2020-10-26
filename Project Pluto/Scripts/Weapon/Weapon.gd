class_name Weapon
extends Sprite


onready var animation_player: AnimationPlayer = $AnimationPlayer


func use() -> void:
	animation_player.play('stab')
