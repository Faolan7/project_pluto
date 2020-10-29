class_name Room
extends TileMap


signal room_exited(dir)


var active: bool = false setget set_active

onready var camera: Camera2D = $Camera2D as Camera2D
onready var enemy_tracker: Node2D = $EnemyTracker as Node2D

onready var doors: Node2D = $Doors as Node2D
onready var north_door: Door = get_node_or_null('Doors/NorthDoor') as Door
onready var south_door: Door = get_node_or_null('Doors/SouthDoor') as Door
onready var east_door: Door = get_node_or_null('Doors/EastDoor') as Door
onready var west_door: Door = get_node_or_null('Doors/WestDoor') as Door


func enter(enter_dir: Vector2) -> void:
	set_active(true)
	
	match enter_dir:
		Vector2.UP:
			south_door.is_open = true
		Vector2.DOWN:
			north_door.is_open = true
		Vector2.LEFT:
			east_door.is_open = true
		Vector2.RIGHT:
			west_door.is_open = true


func set_active(value: bool) -> void:
	active = value
	
	camera.current = value
	if enemy_tracker.get_child_count() > 0:
		set_doors_open(false)

func set_doors_open(value: bool) -> void:
	for door in doors.get_children():
		door.is_open = value


func _on_door_entered(dir: Vector2) -> void:
	emit_signal('room_exited', dir)

func _on_room_cleared() -> void:
	set_doors_open(true)
