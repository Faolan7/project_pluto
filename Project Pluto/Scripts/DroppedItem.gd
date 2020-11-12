extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# If we did this, we would have to preload every single 



# Called when the node enters the scene tree for the first time.
func _ready():
	$Weapon.visible = true

func item_grabbed() -> Weapon:
	return $Weapon as Weapon
