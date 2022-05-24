extends Control


func _enter_tree():
	pause_mode  = Node.PAUSE_MODE_INHERIT
	
func ResetGame():
	get_tree().reload_current_scene()
