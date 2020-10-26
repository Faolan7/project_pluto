extends State


var move_dir: Vector2 = Vector2.ZERO

onready var player: KinematicBody2D = get_node("../..") as KinematicBody2D


func _physics_process(_delta: float) -> void:
	# warning-ignore:return_value_discarded
	player.move_and_slide(move_dir * 100)
