extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var damageTime = 0.2

var currentTimer = 0.0

var enemyDamage = 0.2

var playerHealth : Health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if playerHealth == null:
		return
	currentTimer += delta
	if currentTimer >= damageTime:
		currentTimer = 0.0
		_dealPlayerDamage()
	
	pass

func _dealPlayerDamage():
	playerHealth.TakeDamage(enemyDamage)
	pass


func _on_Area2D_area_entered(area):
	if area is Health:
		if area.is_in_group("player"):
			playerHealth = area
			_dealPlayerDamage()


func _on_Area2D_area_exited(area):
	if playerHealth != null:
		playerHealth = null
