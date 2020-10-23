extends KinematicBody2D


export(int) var health: int setget set_health

onready var health_bar: HealthBar = $HealthBar as HealthBar


func _ready() -> void:
	health_bar.max_health = health


func set_health(value: int) -> void:
	health = value
	
	if health <= 0: # Checking if dead
		queue_free()
		return
		
	if health_bar != null: # Export sets value before children are created
		health_bar.update_bar(health)


func _on_hit(_area: Area2D):
	set_health(health - 1)
