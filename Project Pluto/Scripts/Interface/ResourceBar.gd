class_name ResourceBar
extends Range


func _ready() -> void:
	if value == 0:
		value = max_value


func update_bar(new_value: int) -> void:
	value = new_value
