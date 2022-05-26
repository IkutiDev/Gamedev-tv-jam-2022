extends Node2D

class_name Boomerang

enum Direction{
	Enemy,
	Player
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 100.0
export var damage = 20
var entityHealth : Health

var _currentPosition = Vector2.ZERO
var _currentDirection = Direction.Enemy

var _player : Player
var _enemy : BaseEnemy


func Init(enemy, player):
	_player = player
	_enemy = enemy
	


func _process(delta):
	if _currentDirection == Direction.Enemy and is_instance_valid(_enemy):
		_currentPosition = _enemy.global_position
	elif _currentDirection != Direction.Player:
		_currentDirection = Direction.Player
	elif _currentDirection == Direction.Player:
		_currentPosition = _player.global_position
	var direction_vector = Vector2.ZERO
	direction_vector = global_position.direction_to(_currentPosition).normalized()
	
	
	if direction_vector.x > 0:
		scale.x = scale.y * 1
	if direction_vector.x < 0:
		scale.x = scale.y * -1


	global_position = global_position.move_toward(_currentPosition, delta * speed)
	
	if global_position == _currentPosition:
		if _currentDirection == Direction.Enemy:
			_currentDirection = Direction.Player
		elif _currentDirection == Direction.Player:
			queue_free()
			



func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)

func _on_Area2D_area_entered(area):
	if area is Health:
		_dealDamage(area)
