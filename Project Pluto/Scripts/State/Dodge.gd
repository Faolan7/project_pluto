extends State


var dodge_dir: Vector2 = Vector2.ZERO

export var DODGE_SPEED: int
export var stamina_cost: float


func activate() -> void:
	if actor.stamina >= stamina_cost:
		actor.stamina -= stamina_cost
		.activate()
		actor.animation_state.travel('dodge')


func _physics_process(_delta: float) -> void:
	# warning-ignore:return_value_discarded
	actor.move_and_slide(dodge_dir * DODGE_SPEED)


func _on_animation_finished():
	set_completed(true)
