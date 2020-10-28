class_name Door
extends StaticBody2D


signal entered


export(bool) var is_open: bool = true setget set_open

onready var collision_box = $WorldCollision
onready var sprite = $Sprite


func _ready() -> void:
	set_open(is_open)


func set_open(value: bool) -> void:
	is_open = value
	
	if collision_box != null: # Export sets value before children are created
		collision_box.disabled = value
		sprite.visible = not value


func _on_door_entered(_body: PhysicsBody2D) -> void:
	emit_signal('entered')
