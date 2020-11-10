extends Node2D

onready var dialogue = $DialogueBox

func _ready():
	dialogue.display_text("Hello world.")
