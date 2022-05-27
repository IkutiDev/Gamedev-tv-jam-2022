extends Node2D

#Enemies

class_name BloodPool

var enemies : Array
export var shrinkSpeed = 1.0
export var shrinkRate = 0.5
export var damageSpeed = 0.1
export var damage = 20

var currentTimer = 0.0

var entityHealth : Health

var minimalScale = Vector2.ONE

func _ready():
	$Timer.start(shrinkSpeed)

func _process(delta):
	if enemies.size() == 0:
		return
	currentTimer += delta
	if currentTimer > damageSpeed:
		currentTimer = 0.0
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
	enemies.erase(area)


func _on_Timer_timeout():
	scale = Vector2(scale.x - shrinkRate, scale.y - shrinkRate)
	if scale <= minimalScale:
		queue_free()
