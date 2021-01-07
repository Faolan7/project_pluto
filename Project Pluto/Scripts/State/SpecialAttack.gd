extends State


var special_attack_cost: float = 5.0


func activate() -> void:
	.activate()
	
	if actor.stamina < special_attack_cost:
		set_completed(true)
	else:
		actor.stamina -= special_attack_cost
		actor.play_animation('special_spin')


func _on_special_completed() -> void:
	set_completed(true)
	actor.play_animation('idle')
