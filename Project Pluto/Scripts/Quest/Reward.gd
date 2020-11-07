class_name Reward
extends Node

var xp: int
var gold: int
var items: Array = []


func init(passed_xp: int, passed_gold: int, passed_items: Array) -> void:
	xp = passed_xp
	gold = passed_gold
	items = passed_items


func quest_completed() -> void:
	print("I would quit but the code below me is commented out")
#	get_tree().quit()
