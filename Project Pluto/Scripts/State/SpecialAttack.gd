class_name SpecialState
extends State


var attack_dir: Vector2
var weapon: Weapon setget _set_weapon


func activate() -> void:
	.activate()
	
	if actor.stamina < weapon.special_stamina_cost:
		set_completed(true)
	else:
		actor.stamina -= weapon.special_stamina_cost
		weapon.use_special(attack_dir.angle())


func _set_weapon(value: Weapon) -> void:
	if weapon != null:
		weapon.disconnect('special_finished', self, '_on_special_completed')
		
	weapon = value
	weapon.entity = actor
	# warning-ignore:return_value_discarded
	weapon.connect('special_finished', self, '_on_special_completed')


func _on_special_completed() -> void:
	set_completed(true)
	actor.play_animation('idle')
