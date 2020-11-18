class_name RoomLayout
extends TileMap


signal room_exited(exit_dir)


onready var WALL_ID: int = tile_set.find_tile_by_name('wall')

onready var camera: Camera2D = $Camera2D as Camera2D
onready var enemy_tracker: Node2D = $EnemyTracker as Node2D
onready var doors: Dictionary = {
	Vector2.UP: $Doors/NorthDoor as Door,
	Vector2.DOWN: $Doors/SouthDoor as Door,
	Vector2.LEFT: $Doors/WestDoor as Door,
	Vector2.RIGHT: $Doors/EastDoor as Door,
}


func enter(enter_dir: Vector2, cleared: bool) -> void:
	if cleared:
		# Removing enemies
		for child in enemy_tracker.get_children():
			enemy_tracker.remove_child(child)
			
	camera.current = true
	
	# Closing/opening doors
	if enemy_tracker.get_child_count() > 0:
		set_doors_open(false)
	doors[enter_dir].is_open = true

func set_doors_open(value: bool) -> void:
	for door in doors.values():
		door.is_open = value

func remove_door(side: Vector2) -> void:
	var door: Door = doors[side] as Door
	var offset: Vector2 = Vector2(1, 1)
	
	# Hiding door
	door.visible = false
	
	# Replacing floor tiles with wall tiles
	set_cellv(world_to_map(door.position + offset), WALL_ID)
	set_cellv(world_to_map(door.position - offset), WALL_ID)


func _on_door_entered(side: Vector2) -> void:
	camera.current = false
	emit_signal('room_exited', side)

func _on_room_cleared() -> void:
	set_doors_open(true)
