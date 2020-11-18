class_name Enemy
extends KinematicBody2D


signal died


var is_dead setget, get_is_dead

export(int) var health: int setget set_health

onready var health_bar: HealthBar = $HealthBar as HealthBar


func _ready() -> void:
	health_bar.max_health = health


func set_health(value: int) -> void:
	health = value
	
	if get_is_dead():
		emit_signal('died')
		queue_free()
		return
		
	if health_bar != null: # Export sets value before children are created
		health_bar.update_bar(health)

func get_is_dead() -> bool:
	return health <= 0


func _on_hit(damage: int) -> void:
	set_health(health - damage)
