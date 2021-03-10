extends ColorRect


onready var labels: Node2D = $Labels

export var scroll_speed: float


func _physics_process(delta) -> void:
	labels.position += Vector2.UP * delta * scroll_speed
	if labels.position.y <= -1000:
		labels.position.y = -1000
		set_physics_process(false)


func _on_exit_pressed() -> void:
	get_tree().quit()
