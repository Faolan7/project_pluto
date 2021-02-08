extends Sprite

func _on_interaction(_player) -> void:
	
	_player.key_ring += 1
	$InteractBox.finish_interaction()
	queue_free()
