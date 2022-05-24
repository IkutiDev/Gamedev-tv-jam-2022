extends Control

signal ExitPanel

func _enter_tree():
	pause_mode  = Node.PAUSE_MODE_INHERIT

func _on_NextButton_pressed():
	emit_signal("ExitPanel")
