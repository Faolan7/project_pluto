extends State


var move_dir: Vector2 = Vector2.ZERO

export(int) var MOVE_SPEED: int


func _physics_process(_delta: float) -> void:
	# warning-ignore:return_value_discarded
	actor.move_and_slide(move_dir * MOVE_SPEED)
