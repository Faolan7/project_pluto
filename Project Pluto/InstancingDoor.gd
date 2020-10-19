extends Node2D

onready var doorsprite = preload("res://Door.tscn")

var door_coordinates = [
	Vector2(140, 160),
	Vector2(340, 160),
	Vector2(240, 60),
	Vector2(240, 260)
]


func _ready():
	
	randomize()
	door_coordinates.shuffle()
	
	var number_of_doors: int = determine_number_of_doors()
	var door_array = fill_door_array(number_of_doors)
	
	for n in range(0, door_array.size()):
		add_child(door_array[n])
		
	pass

func determine_number_of_doors() -> int: 
	return randi() % 4 + 1
	
	
func fill_door_array(num_of_doors) -> Array:
	
	var returned_array: Array = []
	
	for n in range(0, num_of_doors):
		var temp_door_array = [doorsprite.instance()]
		
		returned_array += temp_door_array
		returned_array[n].position = door_coordinates[n]
	
	return returned_array
