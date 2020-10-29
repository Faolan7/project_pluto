extends Node2D


onready var current_room: Room = $Rooms/Room as Room
onready var other_room: Room = $Rooms/Room2 as Room


func _ready():
	current_room.add_connection(other_room, Vector2.UP)
	
	current_room.is_loaded = true
	other_room.is_loaded = true
	
	current_room.active = true


func _on_room_exited(exit_dir: Vector2) -> void:
	var old_room = current_room
	current_room = current_room.connections[exit_dir] as Room
	
	for connection in old_room.connections.values():
		if connection != null and connection != current_room:
			connection.is_loaded = false
