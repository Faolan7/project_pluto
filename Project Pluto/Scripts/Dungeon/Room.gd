class_name Room
extends Node2D


signal room_exited(exit_dir)


var active: bool setget set_active, get_active
var is_loaded: bool setget set_loaded

var layout
var connections: Dictionary = {
	Vector2.UP: null,
	Vector2.DOWN: null,
	Vector2.LEFT: null,
	Vector2.RIGHT: null
}

export(Resource) var LAYOUT_SCENE: Resource


func enter(enter_dir: Vector2) -> void:
	layout.enter(enter_dir)

func add_connection(other: Room, side: Vector2) -> void:
	connections[side] = other
	other.connections[side * -1] = self


func set_active(value: bool) -> void:
	layout.active = value

func set_loaded(value: bool) -> void:
	is_loaded = value
	
	if not value:
		remove_child(layout)
	else:
		layout = LAYOUT_SCENE.instance() as RoomLayout
		add_child(layout)
		# warning-ignore:return_value_discarded
		layout.connect('room_exited', self, '_on_room_exited')
		
		for dir in connections.keys():
			if connections[dir] == null:
				layout.remove_door(dir)


func get_active() -> bool:
	return layout.active


func _on_room_exited(exit_dir: Vector2) -> void:
	set_active(false)
	connections[exit_dir].enter(exit_dir * -1)
	
	emit_signal('room_exited', exit_dir)
