class_name Character
extends KinematicBody2D


var face_dir: Vector2 = Vector2.RIGHT setget set_face_dir
var health: float setget set_health, get_health
var stamina: float setget set_stamina, get_stamina

onready var state_machine: StateMachine = $StateMachine as StateMachine
onready var move_state: State = $StateMachine/Move as State
onready var attack_state: State = $StateMachine/Attack as State
onready var health_bar: ResourceBar = $Sprite/Bars/HealthBar as ResourceBar
onready var stamina_bar: ResourceBar = $Sprite/Bars/StaminaBar as ResourceBar

onready var animation_tree: AnimationTree = $AnimationTree as AnimationTree
onready var animation_state: AnimationNodeStateMachinePlayback = animation_tree.get('parameters/playback') as AnimationNodeStateMachinePlayback
onready var facing_pivot: Node2D = $Sprite/FacingPivot as Node2D
onready var hurtbox: HurtBox = $HurtBox as HurtBox

export(float) var stamina_regen_rate: float = 1 # In stamina/second


func _ready() -> void:
	animation_tree.active = true


func drop_weapon(weapon: Weapon) -> void:
	var dropped_weapon: DroppedWeapon = DroppedWeapon.init(position - Vector2(0, 1), weapon)
	get_parent().call_deferred('add_child', dropped_weapon)

func play_animation(animation: String) -> void:
	animation_state.travel(animation)


func set_face_dir(value: Vector2) -> void:
	attack_state.attack_dir = value
	
	if abs(face_dir.angle_to(value)) > PI / 3:
		if abs(value.x) > abs(value.y):
			face_dir.x = value.x / abs(value.x)
			face_dir.y = 0
		else:
			face_dir.x = 0
			face_dir.y = value.y / abs(value.y)
			
		set_blend_position(face_dir)
		facing_pivot.rotation = face_dir.angle()
		facing_pivot.show_behind_parent = face_dir == Vector2.UP

func set_health(value: float) -> void:
	health_bar.value = value

func get_health() -> float:
	return health_bar.value

func get_max_health() -> float:
	return health_bar.max_value

func set_stamina(value: float) -> void:
	stamina_bar.value = value

func get_stamina() -> float:
	return stamina_bar.value

func get_max_stamina() -> float:
	return stamina_bar.max_value

func set_blend_position(value: Vector2) -> void:
	animation_tree.set('parameters/idle/blend_position', value)
	animation_tree.set('parameters/move/blend_position', value)


func _on_damaged(damage: float) -> void:
	set_health(get_health() - damage)

func _on_stamina_regen() -> void:
	var stamina_gain: float = stamina_regen_rate / 5 # Occurs 5 times per second
	set_stamina(get_stamina() + stamina_gain)
