extends Sprite 


func _unhandled_input(event: InputEvent) -> void:
	if(Input.get_action_strength("attack")):
		print('charge!!!')
