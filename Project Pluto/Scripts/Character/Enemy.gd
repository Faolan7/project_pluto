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

onready var combat_distance_node: Position2D = $Sprite/CombatDistance as Position2D

export var PANIC_THRESHOLD: float
export var PATIENCE_THRESHOLD: float
export var COMBAT_DISTANCE: float
export var weapon: NodePath


func _ready() -> void:
	._ready()
	attack_state.weapon = get_node(weapon)
	combat_distance = COMBAT_DISTANCE if COMBAT_DISTANCE != 0 else combat_distance_node.position.length()
	combat_distance *= $Sprite.scale.length()
	
	set_state('wander')

func _physics_process(_delta) -> void:
	if target != null and state_machine.current_state == move_state:
		var to_target: Vector2 = target.position - position
		var target_distance: float = to_target.length()
		set_face_dir(to_target)
		
		if target_distance > combat_distance:
			move_state.move_dir = to_target
			play_animation('move')
		elif target_distance < combat_distance * .9:
			move_state.move_dir = -to_target
			play_animation('move')
		else:
			move_state.move_dir = Vector2.ZERO
			play_animation('idle')
			
		if get_stamina() >= attack_state.weapon.attack_stamina_cost and should_attack():
			animation_player.play('attack')
		elif get_stamina() >= special_stamina_cost and attack_state.weapon.has_entity_in_range(target):
			animation_player.play('attack')
			#print("I'm using my SPECIAL!")

func get_class() -> String:
	return 'Enemy'

func is_class(cls: String) -> bool:
	return cls == get_class()


func should_attack() -> bool:
	if attack_state.weapon.has_entity_in_range(target) \
			and (get_health() < PANIC_THRESHOLD * get_max_health()
				or get_stamina() < PATIENCE_THRESHOLD * special_stamina_cost):
		return true
	else:
		return false


func set_health(value: float) -> void:
	.set_health(value)
	
	if health_bar != null:
		if get_is_dead():
			emit_signal('died')
			on_death()
			return

func get_is_dead() -> bool:
	return get_health() <= 0

func set_state(state: String) -> void:
	match state:
		'attack':
			state_machine.change_state(attack_state)
		'idle':
			play_animation('idle')
			state_machine.change_state(idle_state)
		'move':
			play_animation('move')
			state_machine.change_state(move_state)
		'wander':
			state_machine.change_state(wander_state)

func set_target(body: Character) -> void:
	target = body
	set_state('move')


func on_death():
	attack_state.weapon.animation_player.stop(true)
	drop_weapon(attack_state.weapon)
	queue_free()

func _on_attack_completed() -> void:
	set_state('move')

func _on_target_detected(body: PhysicsBody2D) -> void:
	get_tree().call_group('Enemies', 'set_target', body)
