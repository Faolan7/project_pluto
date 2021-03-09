extends Node2D


const PLAYER_SCENE = preload('res://Scenes/Character/Player.tscn')

var player: Player
var current_room: Room

onready var rooms: Node2D = $Rooms as Node2D
onready var sound_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer


func _ready():
	get_parent().call_deferred('move_child', self, 0)
	
	# Setting up player
	player = PLAYER_SCENE.instance() as Player
	add_child(player) # Makes player always have a parent
	UI.player = player
	
	# Preparing all the rooms
	for room in rooms.get_children():
		room.connect('room_exited', self, '_on_room_exited')
		
	# Getting and loading the current room
	current_room = rooms.get_child(0)
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

func _on_room_loaded(music: String, enter_dir: Vector2, room: Room) -> void:
	# Changing music
	if music != sound_player.current_animation:
		sound_player.play(music)
		
	# Entering room
	room.enter(enter_dir, player)
