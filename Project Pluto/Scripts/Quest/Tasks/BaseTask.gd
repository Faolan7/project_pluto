class_name Task
extends Node


# warning-ignore:unused_signal
signal completed


var is_complete: bool setget set_complete, get_complete


func set_complete(value: bool) -> void:
	is_complete = value

func get_complete() -> bool:
	return is_complete
