extends Node2D

#Enemies

var enemies : Array
export var garlicSpeed = 0.5
export var damage = 10

var currentGarlicTimer = 0.0

var entityHealth : Health

func _process(delta):
	if enemies.size() == 0:
		return
	currentGarlicTimer += delta
	if currentGarlicTimer > garlicSpeed:
		currentGarlicTimer = 0.0
		for i in enemies.size():
			_dealDamage(enemies[i])

func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)

func _on_Area2D_area_entered(area):
	if area is Health:
		enemies.append(area)


func _on_Area2D_area_exited(area):
	enemies.erase(area)
