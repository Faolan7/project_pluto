extends Node2D


onready var current_room: Room = $Rooms/Room as Room
onready var player
const PLAYER_SCENE = preload('res://Scenes/Player.tscn')

func _ready():
	get_parent().call_deferred('move_child', self, 0)
	
	current_room.add_connection($Rooms/Room2, Vector2.UP)
	
	current_room.is_loaded = true
	player = PLAYER_SCENE.instance()
	current_room.add_child(player)
	player.position = Vector2(128, 96)
	
func _on_room_exited(exit_dir: Vector2) -> void:
	# Switching rooms
	var old_room: Room = current_room
	current_room = current_room.connections[exit_dir] as Room
	
	# Unloading old room
	old_room.set_deferred('is_loaded', false)
	
	# Loading new room
	# warning-ignore:return_value_discarded
	current_room.connect('loaded', self, '_on_room_loaded',
		[exit_dir * -1, current_room], CONNECT_ONESHOT)
	current_room.set_deferred('is_loaded', true)

func _on_room_loaded(enter_dir: Vector2, room: Room)->void:
	room.enter(enter_dir, player)
