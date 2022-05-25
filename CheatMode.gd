extends Node2D

signal add_50_revenge
signal decrease_50_hp

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("add_50_revenge"):
		emit_signal("add_50_revenge")
	if Input.is_action_just_pressed("decrease_50_hp"):
		emit_signal("decrease_50_hp")
