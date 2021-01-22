extends Sprite


signal solved


var is_solved: bool = false setget set_solved


func set_solved(value: bool) -> void:
	is_solved = value
	
	frame = 1 if is_solved else 0


func _on_pressed(_body) -> void:
	set_solved(true)
	emit_signal('solved')
