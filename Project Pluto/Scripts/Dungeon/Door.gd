class_name Door
extends StaticBody2D


signal entered


var active: bool = false setget set_active

export(bool) var is_open: bool = true setget set_open

onready var collision_box: CollisionShape2D = $WorldCollision as CollisionShape2D
onready var exit_shape: CollisionShape2D = $ExitArea/CollisionShape2D as CollisionShape2D
onready var sprite: Sprite = $Sprite as Sprite


func _ready() -> void:
	set_open(is_open)


func set_active(value: bool) -> void:
	active = value

func set_open(value: bool) -> void:
	is_open = value
	
	if collision_box != null: # Export sets value before children are created
		collision_box.set_deferred('disabled', is_open)
		sprite.visible = not is_open


func _on_door_entered(_body: PhysicsBody2D) -> void:
	emit_signal('entered')
