class_name SpecialState
extends State


var special_attack_cost: float = 5.0
var attack_dir: Vector2
var weapon: Weapon setget _set_weapon


func activate() -> void:
	.activate()
	
	if actor.stamina < special_attack_cost:
		set_completed(true)
	else:
		actor.stamina -= special_attack_cost
		#actor.play_animation('special_spin')
		weapon.use_special(attack_dir.angle())


func _on_special_completed() -> void:
	set_completed(true)
	actor.play_animation('idle')


func _set_weapon(value: Weapon) -> void:
	if weapon != null:
		weapon.disconnect('special_finished', self, '_on_special_completed')
		
	weapon = value
	weapon.wielder = actor  #problem associated with refactor
	# warning-ignore:return_value_discarded
	weapon.connect('special_finished', self, '_on_special_completed')
