extends TileMap


func _on_roomcleared():
	$NorthDoor.is_open = true
