extends Area2D 

onready var enemies_in_zone:int = 0

onready var enemy_in_zone: Area2D


func _unhandled_input(event: InputEvent) -> void:
	if(Input.get_action_strength("attack")):
		if(enemies_in_zone):
			print("hit")
			enemy_in_zone.queue_free()
		else:
			print("miss")

func _on_Weapon_area_entered(area):
	enemy_in_zone = area
	enemies_in_zone = 1

func _on_Weapon_area_exited(area):
	enemies_in_zone = 0
