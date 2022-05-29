extends Node2D

class_name BloodBomb

export var BloodBombExplosionScene : PackedScene
export var speed = 10
export var damage = 10

var _enemy : BaseEnemy
var _enemyPosition = Vector2.ZERO
var entityHealth : Health

func Init(enemy):
	_enemy = enemy as BaseEnemy
	_enemyPosition = _enemy.global_position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if is_instance_valid(_enemy):
		_enemyPosition = _enemy.global_position
	var direction_vector = Vector2.ZERO
	direction_vector = global_position.direction_to(_enemyPosition).normalized()
	
	
	if direction_vector.x > 0:
		scale.x = scale.y * 1
	if direction_vector.x < 0:
		scale.x = scale.y * -1


	global_position = global_position.move_toward(_enemyPosition, delta * speed)
	
	if global_position == _enemyPosition:
		SpawnExplosion()

func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)

func _on_Area2D_area_entered(area):
	var health = area as Health
	if health == null:
		return
	var enemy = health.get_parent() as BaseEnemy
	if enemy != null and enemy == _enemy:
		_dealDamage(area)
		SpawnExplosion()
	
func SpawnExplosion():
	var bloodBombExplosionInstance = BloodBombExplosionScene.instance()
	bloodBombExplosionInstance.global_position = global_position
	bloodBombExplosionInstance.add_to_group("Temp")
	get_tree().get_root().call_deferred("add_child", bloodBombExplosionInstance)
	queue_free()
