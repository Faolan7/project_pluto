extends Area2D


signal damaged(damage)


func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		var hitbox: Hitbox = area as Hitbox
		
		emit_signal('damaged', hitbox.damage)
