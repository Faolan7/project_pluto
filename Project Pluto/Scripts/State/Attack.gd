extends State


var weapon: Weapon setget _set_weapon


func activate():
	.activate()
	is_completed = false
	weapon.use()


func _set_weapon(value: Weapon):
	if weapon != null:
		weapon.disconnect('attack_finished', self, '_on_attack_completed')
	
	weapon = value
	# warning-ignore:return_value_discarded
	weapon.connect('attack_finished', self, '_on_attack_completed')


func _on_attack_completed():
	is_completed = true

