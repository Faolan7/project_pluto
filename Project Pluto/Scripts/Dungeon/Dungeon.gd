extends Node2D


onready var current_room: Room = $Rooms/Room as Room
onready var player: Player = $Player as Player


func _ready():
	var other_room: Room = $Rooms/Room2 as Room
	
	current_room.add_connection(other_room, Vector2.DOWN)
	
	current_room.is_loaded = true
	current_room.enter(Vector2.DOWN)


func _on_room_exited(exit_dir: Vector2) -> void:
	# Switching rooms
	var old_room: Room = current_room
	current_room = current_room.connections[exit_dir] as Room
	
	# Unloading far away rooms
	old_room.set_deferred('is_loaded', false)
	current_room.connect('loaded', self, 'on_room_loaded', [exit_dir*-1, current_room])
	current_room.set_deferred('is_loaded', true)


func on_room_loaded(enter_dir: Vector2, room: Room)->void:
	room.disconnect('ready', self, 'on_room_loaded')
	room.enter(enter_dir)
	player.position = current_room.position + current_room.layout.doors[enter_dir].position
