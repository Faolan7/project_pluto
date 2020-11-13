extends TileMap


func _ready() -> void:
	get_parent().call_deferred('move_child', self, 0)


func _on_room_cleared() -> void:
	pass
