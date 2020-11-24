class_name Enemy
extends KinematicBody2D


signal died


const DROPPED_WEAPON: Resource = preload('res://Scenes/DroppedWeapon.tscn')

var is_dead setget, get_is_dead
var target: KinematicBody2D

onready var state_machine: StateMachine = $StateMachine as StateMachine
onready var move_state: State = $StateMachine/MoveState as State
onready var attack_state: State = $StateMachine/AttackState as State

onready var health_bar: HealthBar = $HealthBar as HealthBar
onready var weapon: Weapon = $Weapon as Weapon

export(int) var health: int setget set_health


func _ready() -> void:
	health_bar.max_health = health
	attack_state.weapon = weapon
	state_machine.change_state(move_state)

func _physics_process(_delta):
	if target != null:
		move_state.move_dir = target.position - position


func drop_weapon() -> void:
	var dropped_weapon = DROPPED_WEAPON.instance()
	
	dropped_weapon.init(position, weapon)
	get_parent().get_parent().call_deferred('add_child', dropped_weapon)


func set_health(value: int) -> void:
	health = value
	
	if get_is_dead():
		drop_weapon()

		emit_signal('died')
		queue_free()
		return
		
	if health_bar != null: # Export sets value before children are created
		health_bar.update_bar(health)

func get_is_dead() -> bool:
	return health <= 0


func _on_hit(damage: int) -> void:
	set_health(health - damage)

func _on_target_detected(body):
	target = body

func _on_target_lost(_body):
	target = null
	move_state.move_dir = Vector2.ZERO


func _on_attack_range_entered():
	state_machine.change_state(attack_state)


func _on_attack_finished():
	if weapon.has_targets_in_range():
		_on_attack_range_entered()
	else:
		state_machine.change_state(move_state)
