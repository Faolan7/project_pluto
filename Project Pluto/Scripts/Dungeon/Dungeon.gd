extends Node2D


onready var current_room: Room = $Rooms/Room as Room
onready var other_room: Room = $Rooms/Room2 as Room


func _ready():
	current_room.add_connection(other_room, Vector2.UP)
	
	current_room.is_loaded = true
	other_room.is_loaded = true
	
	current_room.active = true


func _on_room_exited(exit_dir: Vector2) -> void:
	# Switching rooms
	var old_room: Room = current_room
	current_room = current_room.connections[exit_dir] as Room
	
	# Moving the player into the room
	$Player.position += 32 * exit_dir
	
	# Unloading far away rooms
	for connection in old_room.connections.values():
		if connection != null and connection != current_room:
			connection.is_loaded = false
