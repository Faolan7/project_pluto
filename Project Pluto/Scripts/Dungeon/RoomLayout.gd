class_name RoomLayout
extends TileMap


signal room_cleared
signal room_exited(exit_dir)


onready var WALL_ID: int = tile_set.find_tile_by_name('wall')

onready var camera: Camera2D = $Camera2D as Camera2D
onready var entities: EntityTracker = $Entities as EntityTracker
onready var puzzle_elements: PuzzleTracker = $PuzzleElements as PuzzleTracker
onready var doors: Dictionary = {
	Vector2.UP: $Doors/NorthDoor as Door,
	Vector2.DOWN: $Doors/SouthDoor as Door,
	Vector2.LEFT: $Doors/WestDoor as Door,
	Vector2.RIGHT: $Doors/EastDoor as Door,
}


func enter(enter_dir: Vector2, player: Player, cleared: bool) -> void:
	# Closing doors
	set_doors_open(cleared)
	if enter_dir != Vector2.ZERO:
		doors[enter_dir].is_open = true
		
	# Adding player
	player.get_parent().remove_child(player)
	entities.add_child(player)
	player.position = get_enter_position(enter_dir)
	
	# Checking room state
	if cleared:
		entities.remove_enemies()
		puzzle_elements.complete_puzzles()
	elif not entities.has_enemies() and not puzzle_elements.has_puzzles():
		entities.emit_signal('room_cleared')
		
	camera.current = true

func remove_door(side: Vector2) -> void:
	var door: Door = doors[side] as Door
	var offset: Vector2 = Vector2(1, 1)
	
	# Hiding door
	door.visible = false
	
	# Replacing floor tiles with wall tiles
	set_cellv(world_to_map(door.position + offset), WALL_ID)
	set_cellv(world_to_map(door.position - offset), WALL_ID)


func set_doors_open(value: bool) -> void:
	for door in doors.values():
		door.is_open = value

func get_enter_position(enter_dir: Vector2) -> Vector2:
	if enter_dir == Vector2.ZERO:
		return Vector2(128, 96) # Center of room
	else:
		return doors[enter_dir].position


func _on_door_entered(side: Vector2) -> void:
	camera.current = false
	emit_signal('room_exited', side)

func _on_room_cleared() -> void:
	set_doors_open(true)
	emit_signal('room_cleared')
