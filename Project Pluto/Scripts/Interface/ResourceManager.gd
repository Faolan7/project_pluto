extends Node

func set_bar_values(player: Player):
	$Health.max_value = player.get_max_health()
	$Stamina.max_value = player.get_max_stamina()
	$Stamina.visible = true

func _on_hp_update(value: float) -> void:
	$Health.update_bar(value)

func _on_stamina_update(value: float) -> void:
	$Stamina.update_bar(value)
