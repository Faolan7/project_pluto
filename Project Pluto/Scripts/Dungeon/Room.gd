class_name Room
extends Node2D


signal room_exited(exit_dir)
signal loaded()


var LAYOUT_SCENE: Resource
var layout: RoomLayout

var is_loaded: bool setget set_loaded
var cleared: bool = false
var room_data: Dictionary

export(Dictionary) var connections: Dictionary = {
	'up': NodePath(),
	'down': NodePath(),
	'left': NodePath(),
	'right': NodePath()
}


func _ready() -> void:
	# Getting room layout
	if get_child_count() > 0 and get_child(0) is RoomLayout:
		var temp_layout: RoomLayout = get_child(0) as RoomLayout
		LAYOUT_SCENE = load(temp_layout.filename)
		temp_layout.queue_free()
		
	# Converting connections
	for dir in connections.keys():
		var path: NodePath = connections[dir] as NodePath
		var new_key: Vector2
		match dir:
			'up': new_key = Vector2.UP
			'down': new_key = Vector2.DOWN
			'left': new_key = Vector2.LEFT
			'right': new_key = Vector2.RIGHT
			
		if path.is_empty():
			connections[new_key] = null
		else:
			connections[new_key] = get_node(path)

func enter(enter_dir: Vector2, player: Player) -> void:
	layout.enter(enter_dir, player, room_data)

func add_connection(other: Room, side: Vector2) -> void:
	connections[side] = other
	other.connections[side * -1] = self


func set_loaded(value: bool) -> void:
	is_loaded = value
	
	if not value:
		room_data = layout.export_data()
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
