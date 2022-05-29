extends Control


func _enter_tree():
	pause_mode  = Node.PAUSE_MODE_INHERIT
	
func ResetGame():
	get_tree().reload_current_scene()
	get_tree().call_group("Temp", "queue_free")


func _on_NextButton_pressed():
	ResetGame()
