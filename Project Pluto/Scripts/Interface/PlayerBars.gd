class_name PlayerBars
extends Node2D


onready var health_bar: ResourceBar = $Health as ResourceBar
onready var stamina_bar: ResourceBar = $Stamina as ResourceBar


func set_bar_values(player: Player):
	health_bar.max_value = player.get_max_health()
	stamina_bar.max_value = player.get_max_stamina()


func _on_hp_update(value: float) -> void:
	health_bar.update_bar(value)

func _on_stamina_update(value: float) -> void:
	stamina_bar.update_bar(value)
