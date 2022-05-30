extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var projectilScene : PackedScene

export var weaponCooldown = 4.0

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_Timer_timeout()
	$Timer.start(weaponCooldown)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var projectileInstance = projectilScene.instance()
	projectileInstance.global_position = global_position
	projectileInstance.add_to_group("Temp")
	get_tree().get_root().add_child(projectileInstance)
