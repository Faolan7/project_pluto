extends Weapon


onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
onready var hitbox: Hitbox = $Hitbox as Hitbox


func use(_attack_dir: float) -> void:
	animation_player.play('attack')


func use_special(_attack_dir: float) -> void:
	animation_player.play('special_attack')


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	emit_signal("attack_finished")	


func set_wielder(value: Node2D) -> void:
	hitbox.wielder = value


func get_wielder() -> Node2D:
	return hitbox.wielder as Node2D
