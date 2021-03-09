extends RoomLayout


func _on_room_cleared():
	get_tree().change_scene('res://Scenes/Menu/Credits.tscn')
