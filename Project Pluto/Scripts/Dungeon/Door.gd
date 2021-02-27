class_name Door
extends StaticBody2D


signal entered


onready var collision_box: CollisionShape2D = $WorldCollision as CollisionShape2D
onready var sprite: Sprite = $Sprite as Sprite
onready var interact_box: InteractBox = $InteractBox as InteractBox

export(bool) var is_open: bool = false setget set_open
export(bool) var locked: bool = false


func _ready() -> void:
	set_open(is_open)
	set_locked(locked)

func set_locked(value: bool) -> void:
	locked = value
	
	set_open(not locked)
	sprite.frame = 0 if not locked else 1

func set_open(value: bool) -> void:
	is_open = value if not locked else false
	
	if collision_box != null: # Export sets value before children are created
		collision_box.set_deferred('disabled', is_open)
		sprite.visible = not is_open


func _on_door_entered(_body: PhysicsBody2D) -> void:
	emit_signal('entered')

func _on_interaction(player: Player) -> void:
	if locked and player.num_keys > 0:
		player.num_keys -= 1
		set_locked(false)
		
	interact_box.finish_interaction()
