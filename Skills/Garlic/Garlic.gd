extends Node2D

#Enemies

var enemies : Array
var garlicTimer = 0.5
var damage = 10

var currentGarlicTimer = 0.0

var entityHealth : Health

func _process(delta):
	if enemies.size() == 0:
		return
	currentGarlicTimer += delta
	if currentGarlicTimer > garlicTimer:
		currentGarlicTimer = 0.0
		for i in enemies.size():
			_dealDamage(enemies[i])

func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)

func _on_Area2D_area_entered(area):
	if area is Health:
		_dealDamage(area)
		enemies.append(area)


func _on_Area2D_area_exited(area):
	var enemyIndex = enemies.find(area)
	if enemyIndex > -1:
		enemies.remove(enemyIndex)
