class_name HealthBar
extends ColorRect


var max_health: int

onready var MAX_BAR_LEN: float = rect_size[0]
onready var cur_health_bar: ColorRect = $CurrentHealth


func update_bar(value: int) -> void:
	if value == max_health:
		visible = false
	else:
		visible = true
		cur_health_bar.margin_right = value as float / max_health * MAX_BAR_LEN
