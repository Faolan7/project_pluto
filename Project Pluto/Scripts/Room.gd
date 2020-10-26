extends TileMap


func _on_room_cleared():
	$NorthDoor.is_open = true
