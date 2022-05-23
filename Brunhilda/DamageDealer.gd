extends Node2D

#Enemies

var garlicEnemies : Array
var garlicTimer = 0.1
var garlicDamage = 10

var currentGarlicTimer = 0.0

var entityToTakeDamage : Health

func _process(delta):
	currentGarlicTimer += delta
	if currentGarlicTimer > garlicTimer:
		_dealGarlicDamage()

func _dealGarlicDamage():
	currentGarlicTimer = 0.0
	for i in garlicEnemies.size():
		entityToTakeDamage = garlicEnemies[i]
		entityToTakeDamage.TakeDamage(garlicDamage)

func _on_Garlic_area_entered(area):
	if area is Health:
		garlicEnemies.append(area)
	
func _on_Garlic_area_exited(area):
	var enemyIndex = garlicEnemies.find(area)
	if enemyIndex > -1:
		garlicEnemies.remove(enemyIndex)
