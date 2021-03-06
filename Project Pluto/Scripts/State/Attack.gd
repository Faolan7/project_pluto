class_name AttackState
extends State


var weapon: Weapon setget _set_weapon
var attack_dir: Vector2


func activate() -> void:
	.activate()
	
	if actor.stamina < weapon.attack_stamina_cost:
		set_completed(true)
	else:
		actor.stamina -= weapon.attack_stamina_cost
		weapon.use(attack_dir.angle())


func _set_weapon(value: Weapon) -> void:
	if weapon != null:
		weapon.disconnect('attack_finished', self, '_on_attack_completed')
		
	weapon = value
	weapon.entity = actor
	# warning-ignore:return_value_discarded
	weapon.connect('attack_finished', self, '_on_attack_completed')


func _on_attack_completed() -> void:
	set_completed(true)
