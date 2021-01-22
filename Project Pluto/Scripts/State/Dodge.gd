extends State


var dodge_dir: Vector2 = Vector2.ZERO

export(int) var DODGE_SPEED: int
export(float) var stamina_cost: float


func activate() -> void:
	if actor.stamina < stamina_cost:
		set_completed(true)
	else:
		actor.stamina -= stamina_cost
		.activate()
		actor.animation_state.travel('dodge')


func _physics_process(_delta: float) -> void:
	# warning-ignore:return_value_discarded
	actor.move_and_slide(dodge_dir * DODGE_SPEED)


func _on_animation_finished():
	set_completed(true)
