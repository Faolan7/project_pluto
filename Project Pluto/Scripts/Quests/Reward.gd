class_name Reward
extends Node

var xp: int setget set_xp, get_xp
var gold: int setget set_gold, get_gold
var items: Array = [
]


func create_reward(passed_xp: int, passed_gold: int, passed_items: Array) -> void:
	set_xp(passed_xp)
	set_gold(passed_gold)
	set_items(passed_items)


func set_xp(passed_xp: int) -> void:
	xp = passed_xp

func get_xp() -> int:
	return xp


func set_gold(passed_gold: int) -> void:
	gold = passed_gold

func get_gold() -> int:
	return gold


func set_items(passed_items: Array) -> void:
	items = passed_items

func get_items() -> Array:
	return items

func quest_completed() -> void:
	print("I would quit but the code below me is commented out")
#	get_tree().quit()
