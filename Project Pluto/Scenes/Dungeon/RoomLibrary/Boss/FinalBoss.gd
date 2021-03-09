extends RoomLayout


func _on_room_cleared():
	# warning-ignore:return_value_discarded
	get_tree().change_scene('res://Scenes/Menu/Credits.tscn')
