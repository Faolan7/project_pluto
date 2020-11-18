extends InteractBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var weapon: Weapon = $Weapon
# Called when the node enters the scene tree for the first time.
func _ready():
	$Weapon.visible = true

func interact(player: Player):
	.interact(player)
	remove_child(weapon) # Think of this as having weapon in your hand before putting it in your inventory.
	player.add_weapon(weapon)
	finish_interaction()
	queue_free()
