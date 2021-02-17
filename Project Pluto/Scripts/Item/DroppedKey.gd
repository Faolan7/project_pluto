class_name DroppedKey
extends InteractBox


func _on_interaction(player: Player) -> void:
	player.num_keys += 1
	finish_interaction()
	queue_free()
