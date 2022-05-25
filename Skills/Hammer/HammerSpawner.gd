extends Node2D

export var hammerScene : PackedScene
export var cooldown = 5.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(cooldown)
	
	
func SpawnHammer():
	var hammerInstance = hammerScene.instance()
	hammerInstance.global_position = global_position
	get_tree().get_root().add_child(hammerInstance)


func _on_Timer_timeout():
	SpawnHammer()
