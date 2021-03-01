class_name Hitbox
extends Area2D


var entity: PhysicsBody2D setget set_entity

onready var shape: CollisionShape2D = $CollisionShape2D as CollisionShape2D

export(int) var damage: int = 0


func set_entity(value: PhysicsBody2D) -> void:
	entity = value
