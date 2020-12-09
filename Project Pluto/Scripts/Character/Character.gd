class_name Character
extends KinematicBody2D


var face_dir: Vector2 = Vector2.RIGHT setget set_face_dir
var health: float setget set_health, get_health
var stamina: float setget set_stamina, get_stamina

onready var state_machine: StateMachine = $StateMachine as StateMachine
onready var move_state: State = $StateMachine/Move as State
onready var attack_state: State = $StateMachine/Attack as State
onready var facing_pivot: Node2D = $Sprite/FacingPivot as Node2D
onready var special_state: State

onready var health_bar: ResourceBar = $Sprite/Bars/HealthBar as ResourceBar
onready var stamina_bar: ResourceBar = $Sprite/Bars/StaminaBar as ResourceBar

export(float) var stamina_regen_rate: float = 1 # In stamina/second


func set_face_dir(value: Vector2) -> void:
	if abs(face_dir.angle_to(value)) > PI / 3:
		if abs(value.x) > abs(value.y):
			face_dir.x = value.x / abs(value.x)
			face_dir.y = 0
		else:
			face_dir.x = 0
			face_dir.y = value.y / abs(value.y)
			
		facing_pivot.rotation = face_dir.angle()
		facing_pivot.show_behind_parent = face_dir == Vector2.UP

func set_health(value: float) -> void:
	health_bar.value = value

func get_health() -> float:
	return health_bar.value

func set_stamina(value: float) -> void:
	stamina_bar.value = value

func get_stamina() -> float:
	return stamina_bar.value


func _on_damaged(damage) -> void:
	set_health(get_health() - damage)

func _on_stamina_regen() -> void:
	set_stamina(get_stamina() + stamina_regen_rate / 5) # Occurs 5 times per second
