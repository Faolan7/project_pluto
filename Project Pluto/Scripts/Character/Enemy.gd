class_name Enemy
extends Character


signal died

var special_stamina_cost: int = 5

var is_dead setget ,get_is_dead
var target: KinematicBody2D setget set_target
var combat_distance: float

onready var idle_state: State = $StateMachine/Idle as State
onready var wander_state: State = $StateMachine/Wander as State
onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer

onready var weapon: Weapon = $Sprite/FacingPivot/Weapon as Weapon
onready var combat_distance_node: Position2D = $CombatDistance as Position2D

export var PANIC_THRESHOLD: float
export var PATIENCE_THRESHOLD: float
export var COMBAT_DISTANCE: float


func _ready() -> void:
	._ready()
	attack_state.weapon = weapon
	combat_distance = COMBAT_DISTANCE if COMBAT_DISTANCE != 0 else combat_distance_node.position.length()
	
	state_machine.change_state(wander_state)

func _physics_process(_delta) -> void:
	if target != null and state_machine.current_state == move_state:
		var to_target: Vector2 = target.position - position
		var target_distance: float = to_target.length()
		set_face_dir(to_target)
		
		if target_distance > combat_distance:
			move_state.move_dir = to_target
		elif target_distance < combat_distance * .9:
			move_state.move_dir = -to_target
		else:
			move_state.move_dir = Vector2.ZERO
		
		if get_stamina() >= weapon.attack_stamina_cost and should_attack():
			state_machine.change_state(idle_state)
			animation_player.play('attack')
		elif get_stamina() >= special_stamina_cost and weapon.has_targets_in_range():
			state_machine.change_state(idle_state)
			animation_player.play('attack')
			print("I'm using my SPECIAL!")

func should_attack() -> bool:
	if weapon.has_targets_in_range() and (
			get_health() < PANIC_THRESHOLD * get_max_health()
			or get_stamina() < PATIENCE_THRESHOLD * special_stamina_cost):
		return true
	else:
		return false

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
