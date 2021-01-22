extends Weapon

# Known bug list
# 1. The ranged weapon does not pivot with the player
# 3. The Arrows persist after being fired
# 4. Player Script on line 19 needs to be updated each time we test a weapon
# 5. n/a


onready var arrow = preload("res://Scenes/Weapon/Ranged Weapon/Arrow.tscn")
export var arrow_speed = 1000

onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer

func use(attack_dir: float):
	animation_player.play("attack")
	var arrow_instance = arrow.instance()
	get_tree().get_root().add_child(arrow_instance)
	arrow_instance.position = get_global_position()
	arrow_instance.rotation = attack_dir
	arrow_instance.velocity = Vector2(arrow_speed, 0).rotated(attack_dir)
	arrow_instance.set_wielder(get_wielder())


func use_special(attack_dir: float):
	animation_player.play("special_attack")
	var arrow_instance = arrow.instance()
	var arrow_instance2 = arrow.instance()
	var arrow_instance3 = arrow.instance()
	get_tree().get_root().add_child(arrow_instance)
	get_tree().get_root().add_child(arrow_instance2)
	get_tree().get_root().add_child(arrow_instance3)
	arrow_instance.position = get_global_position()
	arrow_instance2.position = get_global_position()
	arrow_instance3.position = get_global_position()
	arrow_instance.rotation = attack_dir
	arrow_instance.velocity = Vector2(arrow_speed, 0).rotated(attack_dir + .1)
	arrow_instance.set_wielder(get_wielder())
	arrow_instance2.rotation = attack_dir
	arrow_instance2.velocity = Vector2(arrow_speed, 0).rotated(attack_dir)
	arrow_instance2.set_wielder(get_wielder())
	arrow_instance3.rotation = attack_dir
	arrow_instance3.velocity = Vector2(arrow_speed, 0).rotated(attack_dir - .1)
	arrow_instance3.set_wielder(get_wielder())	


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	emit_signal("attack_finished")
