extends State


var weapon: Weapon setget _set_weapon
var special_attack_cost: float = 0.0


func activate() -> void:
	.activate()
	special_attack_cost = 5.0
	if actor.stamina < special_attack_cost:
		set_completed(true)
	else:
		actor.stamina -= special_attack_cost
		useSpecial()


func useSpecial() -> void:
	actor.playAnimation('Spin')


func _set_weapon(value: Weapon) -> void:
	if weapon != null:
		weapon.disconnect('attack_finished', self, '_on_attack_completed')
	
	weapon = value
	weapon.wielder = actor
	# warning-ignore:return_value_discarded
	weapon.connect('attack_finished', self, '_on_attack_completed')


func _on_special_completed(_anim: String) -> void:
	print('isdone?')
	set_completed(true)
