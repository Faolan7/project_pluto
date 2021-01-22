extends State


var move_dir: Vector2 = Vector2.ZERO setget set_move_dir

export(int) var MOVE_SPEED: int


func _physics_process(_delta: float) -> void:
	# warning-ignore:return_value_discarded
	actor.move_and_slide(move_dir * MOVE_SPEED)


func activate() -> void:
	.activate()
	set_completed(true)


func set_move_dir(value: Vector2):
	move_dir = value.normalized()
