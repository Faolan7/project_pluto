class_name Hitbox
extends Area2D


var wielder: Node2D
#var collision_handler: FuncRef = funcref(self, 'pass_func')
export(int) var damage: int = 0


func pass_func():
	pass
