extends Node2D

onready var doorsprite = preload("res://Door.tscn")

func _ready():
	var scene = doorsprite.instance()
	scene.position = Vector2(240, 160)
	add_child(scene)
	
	pass
