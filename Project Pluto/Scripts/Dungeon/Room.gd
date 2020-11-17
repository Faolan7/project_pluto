class_name Room
extends Node2D


signal room_exited(exit_dir)
signal loaded()

var is_loaded: bool setget set_loaded
var cleared: bool

var layout
var connections: Dictionary = {
	Vector2.UP: null,
	Vector2.DOWN: null,
	Vector2.LEFT: null,
	Vector2.RIGHT: null
}

export(Resource) var LAYOUT_SCENE: Resource


func enter(enter_dir: Vector2) -> void:
	layout.enter(enter_dir, cleared)

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
		layout.enemy_tracker.connect('room_cleared', self, '_on_room_cleared')
		
		for dir in connections.keys():
			if connections[dir] == null:
				layout.remove_door(dir)
		emit_signal('loaded')
func _on_room_cleared() -> void:
	cleared = true


func _on_room_exited(exit_dir: Vector2) -> void:
	print("no mathew, i do it this way, room")	
	emit_signal('room_exited', exit_dir)
