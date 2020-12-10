extends State


var weapon: Weapon setget _set_weapon
var special_attack_cost: float = 0.0
#onready var ap: AnimationPlayer = get_parent().get_parent().get_child(4) as AnimationPlayer 


func activate() -> void:
	.activate()
	special_attack_cost = 0.5
	if actor.stamina < special_attack_cost:
		set_completed(true)
	else:
		actor.stamina -= special_attack_cost
		useSpecial()


func useSpecial() -> void:
	print('Special Attack!!!')
	set_completed(true)
	#ap.play('Spin')


func _set_weapon(value: Weapon) -> void:
	if weapon != null:
		weapon.disconnect('attack_finished', self, '_on_attack_completed')
	
	weapon = value
	weapon.wielder = actor
	# warning-ignore:return_value_discarded
	weapon.connect('attack_finished', self, '_on_attack_completed')


func _on_attack_completed() -> void:
	set_completed(true)


func _on_animation_finished(_anim_name: String) -> void:
	emit_signal('attack_finished')


