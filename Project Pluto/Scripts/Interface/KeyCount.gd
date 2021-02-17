class_name KeyCount
extends Node2D


onready var label: Label = $Label as Label


func _on_key_update(value: int) -> void:
	label.text = 'x' + str(value)
