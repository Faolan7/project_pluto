extends Node

var hp: float setget set_hp, get_hp
var stamina: float setget set_stamina, get_stamina
var stamina_regen: float setget set_stamina_regen, get_stamina_regen


func set_hp(value: float) -> void:
	hp = value

func get_hp() -> float:
	return hp

func _on_damaged(value: float) -> void:
	print(value)
	set_hp(get_hp() - value)
	$Health.update_bar(get_hp())


func set_stamina(value: float) -> void:
	stamina = value

func get_stamina() -> float:
	return stamina


func set_stamina_regen(value: float) -> void:
	stamina_regen = value

func get_stamina_regen() -> float:
	return stamina_regen


func _on_stamina_used():
	var stamina_gain: float = stamina_regen / 5 # Occurs 5 times per second
	set_stamina(get_stamina() + stamina_gain)
	$Stamina.update_bar(get_stamina())
