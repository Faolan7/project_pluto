extends State


var weapon: Weapon setget _set_weapon


func activate() -> void:
	.activate()
	if actor.stamina > weapon.attack_cost:
		is_completed = false
		weapon.use()
		actor.stamina -= weapon.attack_cost


func _set_weapon(value: Weapon) -> void:
	if weapon != null:
		weapon.disconnect('attack_finished', self, '_on_attack_completed')
	
	weapon = value
	weapon.wielder = actor
	# warning-ignore:return_value_discarded
	weapon.connect('attack_finished', self, '_on_attack_completed')


func _on_attack_completed() -> void:
	is_completed = true
