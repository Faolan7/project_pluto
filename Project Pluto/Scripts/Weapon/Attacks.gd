class_name Attacks
extends Node
# Note: Weapon type is never specified because it causes a cyclic dependency
# and the workaround would be dirty and annoying


static func perform(attack: String, weapon) -> void:
	weapon.visible = true
	
	match attack:
		'stab': stab(weapon)

static func _on_attack_finished(weapon, special: bool) -> void:
	weapon.visible = false
	weapon.emit_signal('attack_finished' if not special else 'special_finished')


static func stab(weapon) -> void:
	var STAB_DURATION: float = .1
	#weapon.tween.connect('tween_completed', Attacks, '_on_attack_finished', [weapon, false])
	
	weapon.tween.interpolate_property(weapon, 'position',
		Vector2(2, 0), weapon.position, STAB_DURATION)
	weapon.tween.start()
	
	yield(weapon.tween, 'tween_completed')
	_on_attack_finished(weapon, false)
