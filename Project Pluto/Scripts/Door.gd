extends StaticBody2D


export(bool) var is_open: bool = false setget set_open

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
	get_tree().quit()
