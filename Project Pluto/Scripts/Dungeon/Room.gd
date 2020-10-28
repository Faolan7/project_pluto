extends TileMap


signal room_exited(dir)


onready var doors: Node2D = $Doors as Node2D
onready var enemy_tracker: Node2D = $EnemyTracker as Node2D


func _ready() -> void:
	if enemy_tracker.get_child_count() > 0:
		set_doors_open(false)


func set_doors_open(value: bool) -> void:
	for door in doors.get_children():
		door.is_open = value


func _on_door_entered(dir: Vector2) -> void:
	emit_signal('room_exited', dir)

func _on_room_cleared() -> void:
	set_doors_open(true)
