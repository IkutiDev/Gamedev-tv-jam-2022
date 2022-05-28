extends Node2D

class_name Bone

export var speed = 10
export var damage = 10
export var bounces = 3
export var selfDestructTime = 10

export var distanceToEnemy = 4

var entityHealth : Health

var currentEnemy : BaseEnemy
var currentProjectileBounces = 0

func _ready():
	$Timer.start(selfDestructTime)

func _process(delta):
	var direction_vector = Vector2.ZERO
	if(!is_instance_valid(currentEnemy)):
		SearchForEnemy()
		return
	if global_position.distance_to(currentEnemy.global_position) < distanceToEnemy:
		SearchForEnemy()
		currentProjectileBounces +=1
		if currentProjectileBounces > bounces:
			queue_free() 
		return
	direction_vector = global_position.direction_to(currentEnemy.global_position).normalized()
	global_position = global_position.move_toward(currentEnemy.global_position, delta * speed)

func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)

func _on_Area2D_area_entered(area):
	var health = area as Health
	if health == null:
		return
	_dealDamage(area)
	
func Init(enemy):
	currentEnemy = enemy as BaseEnemy

func SearchForEnemy():
	randomize()
	var index = randi() % GameManager.enemySpawner.visibleEnemies.size()
	var enemy = GameManager.enemySpawner.visibleEnemies[index]
	while enemy == currentEnemy:
		index = randi() % GameManager.enemySpawner.visibleEnemies.size()
		enemy = GameManager.enemySpawner.visibleEnemies[index]
	currentEnemy = enemy

func _on_Timer_timeout():
	queue_free()
