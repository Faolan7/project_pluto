extends Node

func connect_player(player: Player):
	player.connect('update_health', self, '_on_hp_update')
	player.connect('update_stamina', self, '_on_stamina_update')
	
func _on_hp_update(value: float) -> void:
	$Health.update_bar(value)

func _on_stamina_update(value: float) -> void:
	$Stamina.update_bar(value)
