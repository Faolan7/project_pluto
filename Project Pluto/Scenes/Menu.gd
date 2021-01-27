extends Sprite


func _on_start():
	var dungeon = load('res://Scenes/Dungeon/Dungeon.tscn').instance()
	get_parent().add_child(dungeon)
	
	queue_free()

func _on_quit():
	get_tree().quit()
