class_name RoomLayout
extends TileMap


signal room_cleared
signal room_exited(exit_dir)


onready var WALL_ID: int = tile_set.find_tile_by_name('wall')

onready var camera: Camera2D = $Camera2D as Camera2D
onready var entities: EntityTracker = $Entities as EntityTracker
onready var puzzle_elements: PuzzleTracker = $PuzzleElements as PuzzleTracker
onready var items: Node2D = $Items as Node2D
onready var doors: Dictionary = {
	Vector2.UP: $Doors/NorthDoor as Door,
	Vector2.DOWN: $Doors/SouthDoor as Door,
	Vector2.LEFT: $Doors/WestDoor as Door,
	Vector2.RIGHT: $Doors/EastDoor as Door,
}


func enter(enter_dir: Vector2, player: Player, room_data: Dictionary) -> void:
	set_doors_open(false)
	import_data(room_data)
	
	# Opening entrance door
	if enter_dir != Vector2.ZERO:
		doors[enter_dir].is_open = true
	
	# Adding player
	player.get_parent().remove_child(player)
	entities.add_child(player)
	player.position = get_enter_position(enter_dir)
	
	# Checking room state
	if room_data.get('cleared', false):
		entities.remove_enemies()
		puzzle_elements.complete_puzzles()
	elif not entities.has_enemies() and not puzzle_elements.has_puzzles():
		entities.emit_signal('room_cleared')
		
	camera.current = true

func remove_door(side: Vector2) -> void:
	var door: Door = doors[side] as Door
	var offset: Vector2 = Vector2(4, 4)
	
	# Hiding door
	door.visible = false
	
	# Replacing floor tiles with wall tiles
	set_cellv(world_to_map(door.position + offset), WALL_ID)
	set_cellv(world_to_map(door.position - offset), WALL_ID)

func import_data(data: Dictionary) -> void:
	if data.size() == 0:
		return
		
	# Reading door data
	var data_key: String
	var door_key: Vector2
	for item in [['north_door', Vector2.UP], ['south_door', Vector2.DOWN],
			['west_door', Vector2.LEFT], ['east_door', Vector2.RIGHT]]:
		data_key = item[0]
		door_key = item[1]
		doors[door_key].locked = data[data_key]['locked']
		doors[door_key].is_open = data[data_key]['open']
		
	# Reading item data
	for child in items.get_children():
		child.queue_free()
	for item in data['items']:
		items.add_child(item)

func export_data() -> Dictionary:
	var data: Dictionary = {}
	
	# Storing door data
	var data_key: String
	var door_key: Vector2
	for item in [['north_door', Vector2.UP], ['south_door', Vector2.DOWN],
			['west_door', Vector2.LEFT], ['east_door', Vector2.RIGHT]]:
		data_key = item[0]
		door_key = item[1]
		data[data_key] = {
			'open': doors[door_key].is_open,
			'locked': doors[door_key].locked
		}
		
	# Storing treasure data
	data['items'] = items.get_children()
	for item in items.get_children():
		items.remove_child(item)
		
	return data


func set_doors_open(value: bool) -> void:
	for door in doors.values():
		door.is_open = value

func get_enter_position(enter_dir: Vector2) -> Vector2:
	if enter_dir == Vector2.ZERO:
		return Vector2(256, 192) # Center of room
	else:
		return doors[enter_dir].position


func _on_door_entered(side: Vector2) -> void:
	camera.current = false
	emit_signal('room_exited', side)

func _on_room_cleared() -> void:
	set_doors_open(true)
	emit_signal('room_cleared')
