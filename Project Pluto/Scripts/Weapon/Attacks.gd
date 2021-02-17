class_name Attacks
extends Node
# Note: Weapon type is never specified because it causes a cyclic dependency
# and the workaround would be dirty and annoying


static func perform(attack: String, weapon, attack_dir: float) -> void:
	weapon.visible = true
	
	match attack:
		# Normal attacks
		'shoot': shoot(weapon, attack_dir, 1)
		'stab': stab(weapon)
		# Special attacks
		'spin': spin(weapon)
		'spreadshot3': shoot(weapon, attack_dir, 3)
		# Default
		_: print('ERROR: Unknown attack ' + attack)

static func _on_attack_finished(weapon, special: bool) -> void:
	weapon.visible = false
	weapon.emit_signal('attack_finished' if not special else 'special_finished')


static func shoot(weapon, attack_dir: float, num_projectiles: int) -> void:
	var cone_size: float = (num_projectiles - 1) / 20.0 # Doing floating point division
	var angle_diff: float = -cone_size
	
	weapon.animation_player.play('shoot')
	while angle_diff <= cone_size:
		weapon.create_projectile(attack_dir + angle_diff)
		
		angle_diff += .1
		
	yield(weapon.animation_player, 'animation_finished')
	_on_attack_finished(weapon, false)

static func stab(weapon) -> void:
	weapon.play_tween(weapon, 'position',
		Vector2(2, 0), weapon.position, .1)
		
	yield(weapon.tween, 'tween_completed')
	_on_attack_finished(weapon, false)


static func spin(weapon) -> void:
	var facing_pivot: Node2D = weapon.entity.facing_pivot
	weapon.play_tween(facing_pivot, 'rotation',
		facing_pivot.rotation, facing_pivot.rotation + 2 * PI, .3)
		
	yield(weapon.tween, 'tween_completed')
	_on_attack_finished(weapon, false)
