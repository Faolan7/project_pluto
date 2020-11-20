class_name Room
extends Node2D


signal room_exited(exit_dir)
signal loaded()


var is_loaded: bool setget set_loaded
var cleared: bool

var layout: RoomLayout
var connections: Dictionary = {
	Vector2.UP: null,
	Vector2.DOWN: null,
	Vector2.LEFT: null,
	Vector2.RIGHT: null
}

export(Resource) var LAYOUT_SCENE: Resource


func enter(enter_dir: Vector2, player: Player) -> void:
	layout.enter(enter_dir, cleared)
	player.get_parent().remove_child(player)
	add_child(player)
	player.position = get_enter_position(enter_dir)


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
		layout.enemy_tracker.connect('room_cleared', self, '_on_room_cleared')
		
		for dir in connections.keys():
			if connections[dir] == null:
				layout.remove_door(dir)
		emit_signal('loaded')

func get_enter_position(enter_dir: Vector2) -> Vector2:
	return layout.doors[enter_dir].position


func _on_room_cleared() -> void:
	cleared = true

func _on_room_exited(exit_dir: Vector2) -> void:
	emit_signal('room_exited', exit_dir)
