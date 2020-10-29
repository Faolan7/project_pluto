extends Node2D


onready var current_room: Room = $Rooms/Room as Room
onready var next_room = $Rooms/Room2


func _ready():
	current_room.active = true


func _on_room_exited(dir: Vector2) -> void:
	current_room.active = false
	
	var temp = current_room
	current_room = next_room
	next_room = temp
	current_room.enter(dir)
