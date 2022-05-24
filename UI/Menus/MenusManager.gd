extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var isPaused = get_tree().paused

var gameFinished = false

func _enter_tree():
	pause_mode = Node.PAUSE_MODE_PROCESS

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func _process(delta):
	if gameFinished:
		return
	if Input.is_action_just_released("Pause"):
		if $StoryScreen.is_visible_in_tree():
			$StoryScreen.hide()
			_on_StoryScreen_NextPanel()
		else:
			EnablePauseMenu(!isPaused)

	
func EnablePauseMenu(enable : bool):
	isPaused = enable
	get_tree().paused = enable
	if enable:
		$InfoScreen.show()
	else:
		$InfoScreen.hide()

func ShowWinScreen():
	gameFinished = true
	get_tree().paused = true
	$WinScreen.show()

func ShowLoseScreen():
	gameFinished = true
	get_tree().paused = true
	$LoseScreen.show()

func _on_StoryScreen_NextPanel():
	$InfoScreen.show()


func _on_InfoScreen_ExitPanel():
	EnablePauseMenu(false)