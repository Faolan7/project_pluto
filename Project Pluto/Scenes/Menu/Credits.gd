extends ColorRect


onready var labels: Node2D = $Labels

export var scroll_speed: float


func _physics_process(delta):
	labels.position += Vector2.UP * delta * scroll_speed
	if labels.position.y <= -800:
		labels.position.y = -800
		set_physics_process(false)
