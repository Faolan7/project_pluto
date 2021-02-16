class_name Door
extends StaticBody2D


signal entered


onready var collision_box: CollisionShape2D = $WorldCollision as CollisionShape2D
onready var exit_shape: CollisionShape2D = $ExitArea/CollisionShape2D as CollisionShape2D
onready var sprite: Sprite = $Sprite as Sprite

export(bool) var is_open: bool = true setget set_open


export(bool) var locked_with_key: bool = false

func _ready() -> void:
	set_open(is_open)


func set_open(value: bool) -> void:
	if locked_with_key == true:
		sprite.visible = true
		collision_box.set_deferred('disabled', false)
	else:
		is_open = value
		
		
		if collision_box != null: # Export sets value before children are created
			collision_box.set_deferred('disabled', is_open)
			sprite.visible = not is_open


func _on_door_entered(_body: PhysicsBody2D) -> void:
	emit_signal('entered')


func _on_interaction(_player: Player) -> void:
	print("interaction with door")
	if _player.key_ring != 0 && locked_with_key == true:
		_player.key_ring -= 1
		locked_with_key = false
	check_locks()
	$InteractBox.finish_interaction()

func check_locks() -> void:
	if locked_with_key == false:
		set_open(true)
