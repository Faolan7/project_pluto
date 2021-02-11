extends Node2D


const PLAYER_SCENE = preload('res://Scenes/Character/Player.tscn')

var player: Player

onready var current_room: Room = $Rooms/BeginningRoom as Room


func _ready():
	get_parent().call_deferred('move_child', self, 0)
	
	player = PLAYER_SCENE.instance() as Player
	add_child(player) # Makes player always have a parent
	UI.player = player
	
	for child in $Rooms.get_children():
		child.connect('room_exited', self, '_on_room_exited')
	
	load_room(current_room, Vector2.ZERO)


func load_room(room: Room, enter_dir: Vector2) -> void:
	# warning-ignore:return_value_discarded
	room.connect('loaded', self, '_on_room_loaded', [enter_dir, room], CONNECT_ONESHOT)
	room.set_deferred('is_loaded', true)
	
	UI.position = room.position


func _on_room_exited(exit_dir: Vector2) -> void:
	# Switching rooms
	var old_room: Room = current_room
	current_room = current_room.connections[exit_dir] as Room
	
	old_room.set_deferred('is_loaded', false)
	load_room(current_room, exit_dir * -1)

func _on_room_loaded(enter_dir: Vector2, room: Room)->void:
	room.enter(enter_dir, player)

