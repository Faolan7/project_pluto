extends Button


func _on_start_pressed():
	print("start pressed")
	get_tree().change_scene("res://Scenes/Dungeon/Dungeon.tscn")
