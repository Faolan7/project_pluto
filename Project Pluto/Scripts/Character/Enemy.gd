class_name Enemy
extends Character


signal died


var is_dead setget ,get_is_dead
var target: KinematicBody2D setget set_target

onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer

onready var idle_state: State = $StateMachine/Idle as State
onready var wander_state: State = $StateMachine/Wander as State

onready var weapon: Weapon = $Sprite/FacingPivot/Weapon as Weapon


func _ready() -> void:
	._ready()
	attack_state.weapon = weapon
	state_machine.change_state(wander_state)

func _physics_process(_delta) -> void:
	if target != null and state_machine.current_state == move_state:
		var to_target: Vector2 = target.position - position
		move_state.move_dir = to_target
		set_face_dir(to_target)
		
		if weapon.has_targets_in_range() and get_stamina() > weapon.attack_stamina_cost:
			state_machine.change_state(idle_state)
			animation_player.play('attack')


func do_attack():
	state_machine.change_state(attack_state)


func set_health(value: float) -> void:
	.set_health(value)
	
	if health_bar != null:
		if get_is_dead():
			emit_signal('died')
			on_death()
			return

func get_is_dead() -> bool:
	return get_health() <= 0

func set_target(body) -> void:
	target = body
	state_machine.change_state(move_state)


func on_death():
	weapon.animation_player.stop(true)
	drop_weapon(weapon)
	queue_free()

func _on_attack_completed() -> void:
	state_machine.change_state(move_state)

func _on_target_detected(body) -> void:
	get_tree().call_group('Enemies', 'set_target', body)
