extends AnimationPlayer


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_continue_pressed() -> void:
	get_tree().change_scene("res://Scenes/Menu/Title.tscn")
