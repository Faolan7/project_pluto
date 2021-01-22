class_name Room
extends Node2D


signal room_exited(exit_dir)
signal loaded()


var LAYOUT_SCENE: Resource
var layout: RoomLayout

var is_loaded: bool setget set_loaded
var cleared: bool

export(Dictionary) var connections: Dictionary = {
	Vector2.UP: NodePath(),
	Vector2.DOWN: NodePath(),
	Vector2.LEFT: NodePath(),
	Vector2.RIGHT: NodePath()
}


func _ready() -> void:
	# Getting room layout
	if get_child_count() > 0 and get_child(0) is RoomLayout:
		var layout: RoomLayout = get_child(0) as RoomLayout
		LAYOUT_SCENE = load(layout.filename)
		layout.queue_free()
		
	# Converting connections
	for dir in connections.keys():
		var connection: NodePath = connections[dir] as NodePath
		
		if connection.is_empty():
			connections[dir] = null
		else:
			connections[dir] = get_node(connection)


func enter(enter_dir: Vector2, player: Player) -> void:
	layout.enter(enter_dir, player, cleared)

func add_connection(other: Room, side: Vector2) -> void:
	connections[side] = other
	other.connections[side * -1] = self


func set_loaded(value: bool) -> void:
	is_loaded = value
	
	if not value:
		remove_child(layout)
	else:
		layout = LAYOUT_SCENE.instance() as RoomLayout
		add_child(layout)
		
		# warning-ignore:return_value_discarded
		layout.connect('room_exited', self, '_on_room_exited')
		# warning-ignore:return_value_discarded
		layout.connect('room_cleared', self, '_on_room_cleared')
		
		for dir in connections.keys():
			if connections[dir] == null:
				layout.remove_door(dir)
				
		emit_signal('loaded')


func _on_room_cleared() -> void:
	cleared = true

func _on_room_exited(exit_dir: Vector2) -> void:
	emit_signal('room_exited', exit_dir)
