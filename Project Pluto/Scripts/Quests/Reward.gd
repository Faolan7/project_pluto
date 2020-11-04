class_name Reward
extends Node

var xp: int setget set_xp, get_xp
var gold: int setget set_gold, get_gold
var items: Array = [
	
]

#signal give_reward(xp, gold, items)


func create_reward(passed_xp: int, passed_gold: int, passed_items: Array) -> void:
	set_xp(passed_xp)
	set_gold(passed_gold)
	set_items(passed_items)


func set_xp(passed_xp: int) -> void:
	self.xp = passed_xp

func get_xp() -> int:
	return self.xp


func set_gold(passed_gold: int) -> void:
	self.gold = passed_gold

func get_gold() -> int:
	return self.gold


func set_items(passed_items: Array) -> void:
	self.items = items

func get_items() -> Array:
	return self.items


func quest_completed() -> void:
#	emit_signal("give_reward", get_xp(), get_gold(), get_items())
	get_tree().quit()
