extends Node2D

export var speed = 5
export var damage = 0.5

var entityHealth : Health

var playerPosition = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	playerPosition = GameManager.player.global_position
	$Timer.start(15)


func _process(delta):
	var direction_vector = Vector2.ZERO
	direction_vector = global_position.direction_to(playerPosition).normalized()
	
	
	if direction_vector.x > 0:
		scale.x = scale.y * 1
	if direction_vector.x < 0:
		scale.x = scale.y * -1

	look_at(transform.origin + direction_vector)

	global_position = global_position.move_toward(playerPosition, delta * speed)
	
	if global_position == playerPosition:
		if direction_vector.x > 0:
			playerPosition += Vector2.RIGHT
		if direction_vector.x < 0:
			playerPosition += Vector2.LEFT
		if direction_vector.y > 0:
			playerPosition += Vector2.DOWN
		if direction_vector.y < 0:
			playerPosition += Vector2.UP

func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)

func _on_Area2D_area_entered(area):
	var health = area as Health
	if health == null:
		return
	var player = health.get_parent() as Player
	if player != null:
		_dealDamage(area)


func _on_Timer_timeout():
	queue_free()
