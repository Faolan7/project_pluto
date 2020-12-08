class_name Character
extends KinematicBody2D


var face_dir: Vector2 = Vector2.RIGHT setget set_face_dir
var health: float setget set_health, get_health
var stamina: float setget set_stamina, get_stamina

onready var state_machine: StateMachine = $StateMachine as StateMachine
onready var move_state: State = $StateMachine/Move as State
onready var attack_state: State = $StateMachine/Attack as State
onready var facing_pivot: Node2D = $Sprite/FacingPivot as Node2D

onready var health_bar: ResourceBar = $Sprite/Bars/HealthBar as ResourceBar
onready var stamina_bar: ResourceBar = $Sprite/Bars/StaminaBar as ResourceBar

export(float) var stamina_regen_rate: float = 1 # In stamina/second


func set_face_dir(value: Vector2) -> void:
	var max_comp: float = abs(value.x) if abs(value.x) > abs(value.y) else abs(value.y)
	
	if max_comp != 0 and abs(face_dir.angle_to(value)) > PI / 3:
		var x_comp: float = value.x / max_comp
		var y_comp: float = value.y / max_comp
		
		face_dir = Vector2(
			0.0 if abs(x_comp) < 1 else x_comp,
			0.0 if abs(y_comp) < 1 else y_comp)
			
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
