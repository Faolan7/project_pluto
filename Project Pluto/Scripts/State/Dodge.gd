extends State

var dodge_dir: Vector2 = Vector2.ZERO

export(int) var DODGE_SPEED: int


#Not working how I would like it to. But this functions on a basic level.
func _physics_process(_delta: float) -> void:
	# warning-ignore:return_value_discarded
	actor.move_and_slide(dodge_dir * DODGE_SPEED)
