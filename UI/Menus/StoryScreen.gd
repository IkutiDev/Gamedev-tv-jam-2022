extends Control

signal NextPanel

func _enter_tree():
	pause_mode  = Node.PAUSE_MODE_INHERIT
	
func _ready():
	get_tree().paused = true

func _on_NextButton_pressed():
	emit_signal("NextPanel")
	hide()
