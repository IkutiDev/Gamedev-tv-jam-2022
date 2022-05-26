extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var currentTimer = 0.0



var _enemyStats : BaseEnemy

var playerHealth : Health

func Init(enemyStats):
	_enemyStats = enemyStats as BaseEnemy


func _process(delta):
	if playerHealth == null:
		return
	currentTimer += delta
	if currentTimer >= _enemyStats.enemyDamageSpeed:
		currentTimer = 0.0
		_dealPlayerDamage()
	
	pass

func _dealPlayerDamage():
	playerHealth.TakeDamage(_enemyStats.enemyDamage)
	pass


func _on_Area2D_area_entered(area):
	if area is Health:
		if area.is_in_group("player"):
			playerHealth = area
			_dealPlayerDamage()


func _on_Area2D_area_exited(area):
	if playerHealth != null:
		playerHealth = null
