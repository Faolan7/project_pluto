class_name Enemy
extends KinematicBody2D


export(int) var health: int setget set_health

onready var health_bar: HealthBar = $HealthBar as HealthBar
onready var DROPPED_ITEM: Resource = load("res://Scenes/DroppedItem.tscn")
onready var weapon: Weapon = $Weapon

func _ready() -> void:
	health_bar.max_health = health


func set_health(value: int) -> void:
	health = value
	
	if health <= 0: # Checking if dead
		#instance dropped_item
		var dropped_weapon = DROPPED_ITEM.instance()
		
		#ole switcharoo
		remove_child(weapon)
		dropped_weapon.init(weapon, position)
		
		#add the dropped item as a child of the Dungeon
		get_parent().get_parent().call_deferred("add_child", dropped_weapon)
		
		#remove the dead body
		queue_free()
		return
		
	if health_bar != null: # Export sets value before children are created
		health_bar.update_bar(health)


func _on_hit(damage: int) -> void:
	set_health(health - damage)
