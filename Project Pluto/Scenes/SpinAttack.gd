extends Node2D


onready var special: AnimationPlayer = $SpinPlayer as AnimationPlayer


func useSpecial() -> void:
	print('Special Attack!!!')
	special.play("Spin")
