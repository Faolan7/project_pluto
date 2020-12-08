class_name Character
extends KinematicBody2D


var face_dir: Vector2 = Vector2.RIGHT setget set_face_dir
var stamina: int

onready var state_machine: StateMachine = $StateMachine as StateMachine
onready var move_state: State = $StateMachine/Move as State
onready var attack_state: State = $StateMachine/Attack as State
onready var facing_pivot: Node2D = $Sprite/FacingPivot as Node2D

export(int) var max_stamina
export(int) var stamina_regen_rate


func _ready() -> void:
	stamina = max_stamina


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


func _on_stamina_regen():
	stamina = clamp(stamina + stamina_regen_rate / 5, 0, max_stamina)
