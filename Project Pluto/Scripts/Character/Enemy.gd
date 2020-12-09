class_name Enemy
extends Character


signal died


const DROPPED_WEAPON: Resource = preload('res://Scenes/DroppedWeapon.tscn')

var is_dead setget, get_is_dead
var target: KinematicBody2D

onready var weapon: Weapon = $Sprite/FacingPivot/Weapon as Weapon


func _ready() -> void:
	._ready()
	attack_state.weapon = weapon
	state_machine.change_state(move_state)

func _physics_process(_delta) -> void:
	if target != null and state_machine.can_change_state:
		var to_target: Vector2 = target.position - position
		move_state.move_dir = to_target
		set_face_dir(to_target)


func drop_weapon() -> void:
	var dropped_weapon = DROPPED_WEAPON.instance()
	
	dropped_weapon.init(position, weapon)
	get_parent().call_deferred('add_child', dropped_weapon)


func set_health(value: float) -> void:
	.set_health(value)
	
	if health_bar != null:
		if get_is_dead():
			emit_signal('died')
			on_death()
			return

func get_is_dead() -> bool:
	return get_health() <= 0


func on_death():
	weapon.animation_player.stop(true)
	drop_weapon()
	queue_free()

func _on_attack_completed() -> void:
	if weapon.has_targets_in_range() and get_stamina() > weapon.attack_cost:
		_on_attack_range_entered()
	else:
		state_machine.change_state(move_state)

func _on_attack_range_entered() -> void:
	if get_stamina() > weapon.attack_cost:
		state_machine.change_state(attack_state)

func _on_target_detected(body) -> void:
	target = body

func _on_target_lost(_body) -> void:
	target = null
	move_state.move_dir = Vector2.ZERO
