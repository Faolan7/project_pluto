extends State


var move_dir = Vector2.ZERO

onready var player = get_node("../..")


func _physics_process(delta):
	player.move_and_slide(move_dir * 250)

