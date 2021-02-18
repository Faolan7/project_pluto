class_name DodgeState
extends State


var dodge_dir: Vector2 = Vector2.ZERO
var initial_face_dir: Vector2

export(int) var DODGE_SPEED: int
export(float) var stamina_cost: float


func activate() -> void:
	if actor.stamina < stamina_cost:
		set_completed(true)
	else:
		actor.stamina -= stamina_cost
		.activate()
		
		initial_face_dir = actor.face_dir
		actor.face_dir = dodge_dir
		actor.animation_state.travel('dodge')


func _physics_process(_delta: float) -> void:
	# warning-ignore:return_value_discarded
	actor.move_and_slide(dodge_dir * DODGE_SPEED)


func _on_animation_finished():
	actor.face_dir = initial_face_dir
	set_completed(true)
