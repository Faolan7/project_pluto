extends Door

export var num_of_locks: int = 0

func _on_interaction(_player: Player) -> void:
	if _player.key_ring != 0:
		_player.key_ring -= 1
		num_of_locks -= 1
	check_locks()
	$InteractBox.finish_interaction()

func check_locks() -> void:
	if num_of_locks == 0:
		set_open(true)
		queue_free()
