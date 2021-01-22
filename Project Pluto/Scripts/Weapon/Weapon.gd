class_name Weapon
extends Sprite

var wielder: Node2D setget set_wielder, get_wielder
signal attack_finished
signal attack_range_entered #Required for AI


onready var attack_range: Area2D = $AttackRange as Area2D

export var attack_stamina_cost: float

#Required for AI to work
#get_child() hard coded to zero because it should get the weapon attached to this
func has_targets_in_range() -> bool:
	for area in attack_range.get_overlapping_areas():
		if area.get_parent() != get_child(0).get_wielder():
			return true
	return false


func _on_attack_range_entered(area: Area2D) -> void:
	if area.get_parent() != get_child(0).get_wielder():
		emit_signal('attack_range_entered')

func set_wielder(value: Node2D):
	wielder = value

func get_wielder():
	return wielder
