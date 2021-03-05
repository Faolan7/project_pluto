class_name WeaponPillar
extends DroppedWeapon


onready var sprite: AnimatedSprite = $AnimatedSprite as AnimatedSprite


func _ready() -> void:
	sprite.animation = 'default'
	sprite.playing = true


func interact(player):
	emit_signal('interaction_started', player)
	player.add_weapon(get_weapon())
	set_weapon(null)
	
	finish_interaction(false)
	sprite.animation = 'empty'

func set_weapon(value: Weapon) -> void:
	if value == null:
		weapon = null
	else:
		.set_weapon(value)

func get_weapon() -> Weapon:
	return null if weapon == null else .get_weapon()
