extends Node2D

#Enemies

var garlicEnemies : Array
var garlicTimer = 0.5
var garlicDamage = 10

var currentGarlicTimer = 0.0

var entityHealth : Health

func _process(delta):
	if garlicEnemies.size() == 0:
		return
	currentGarlicTimer += delta
	if currentGarlicTimer > garlicTimer:
		currentGarlicTimer = 0.0
		for i in garlicEnemies.size():
			_dealGarlicDamage(garlicEnemies[i])

func _dealGarlicDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(garlicDamage)

func _on_Garlic_area_entered(area):
	if area is Health:
		_dealGarlicDamage(area)
		garlicEnemies.append(area)
	
func _on_Garlic_area_exited(area):
	var enemyIndex = garlicEnemies.find(area)
	if enemyIndex > -1:
		garlicEnemies.remove(enemyIndex)
