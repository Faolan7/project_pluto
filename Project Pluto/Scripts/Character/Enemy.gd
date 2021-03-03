class_name Enemy
extends Character


signal died


var is_dead setget ,get_is_dead
var target: KinematicBody2D setget set_target
var combat_distance: float

onready var idle_state: State = $StateMachine/Idle as State
onready var wander_state: State = $StateMachine/Wander as State
onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer

onready var sprite: Sprite = $Sprite as Sprite
onready var combat_distance_node: Position2D = $Sprite/CombatDistance as Position2D
onready var detection_area_shape: CollisionShape2D = $DetectionArea/CollisionShape2D as CollisionShape2D

export(float) var PANIC_THRESHOLD: float
export(float) var PATIENCE_THRESHOLD: float
export(float) var COMBAT_DISTANCE: float
export(NodePath) var WEAPON_PATH: NodePath


func get_class() -> String:
	return 'Enemy'

func is_class(cls: String) -> bool:
	return cls == get_class()

func _ready() -> void:
	._ready()
	set_weapon(get_node(WEAPON_PATH))
	combat_distance = COMBAT_DISTANCE if COMBAT_DISTANCE != 0 else combat_distance_node.position.length()
	combat_distance *= sprite.scale.length()
	
	set_state('wander')
	set_physics_process(false)

func _physics_process(_delta) -> void:
	if not is_instance_valid(target):
		set_target(null)
	elif state_machine.current_state == move_state:
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
			
		if should_attack():
			#animation_player.play('attack')
			set_state('attack')
		elif should_special():
			#animation_player.play('special')
			set_state('attack')


func should_attack() -> bool:
	# No regular attack
	if weapon.attack_name == '':
		return false
	# No special attack
	elif weapon.special_name == '' \
			and get_stamina() >= weapon.attack_stamina_cost \
			and weapon.has_entity_in_range(target):
		return true
		
	return get_stamina() >= weapon.attack_stamina_cost \
		and weapon.has_entity_in_range(target) \
		and (get_health() < PANIC_THRESHOLD * get_max_health()
			or get_stamina() < PATIENCE_THRESHOLD * weapon.special_stamina_cost)

func should_special() -> bool:
	# No special attack
	if weapon.special_name == '':
		return false
		
	return get_stamina() >= weapon.special_stamina_cost \
		and weapon.has_entity_in_range(target)


func set_health(value: float) -> void:
	.set_health(value)
	
	if health_bar != null:
		if get_is_dead():
			emit_signal('died')
			on_death()
			return

func get_health_percent() -> float:
	return get_health() / get_max_health() * 100

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
		'special':
			state_machine.change_state(special_state)
		'wander':
			state_machine.change_state(wander_state)

func set_target(body: Character) -> void:
	if not body is Player:
		return
		
	target = body
	
	if target == null:
		set_state('wander')
		detection_area_shape.set_deferred('disabled', false)
		set_physics_process(false)
	else:
		set_state('move')
		detection_area_shape.set_deferred('disabled', true)
		set_physics_process(true)


func _on_damaged(damage: float, dealer: Node2D) -> void:
	# Checking if already dead
	if get_is_dead():
		return
		
	._on_damaged(damage, dealer)
	if dealer != target:
		set_target(dealer)
		get_tree().call_group('Enemies', '_on_target_detected', dealer)

func on_death():
	weapon.animation_player.stop(true)
	drop_weapon(weapon)
	queue_free()

func _on_attack_completed() -> void:
	if not is_instance_valid(target):
		set_target(null)
	else:
		set_state('move')

func _on_target_detected(body: PhysicsBody2D) -> void:
	if target == null:
		set_target(body)
		get_tree().call_group('Enemies', '_on_target_detected', body)
