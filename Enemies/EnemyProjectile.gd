extends Node2D

export var speed = 5
export var damage = 0.5
export var health = 20

var entityHealth : Health

var playerPosition = Vector2.ZERO
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	playerPosition = GameManager.player.global_position
	var target_pos = playerPosition
	self.rotation = target_pos.angle()
	velocity = self.global_position.direction_to(target_pos)
	$Timer.start(15)
	$AnimatedSprite/HitboxArea.Init(health)


func _physics_process(delta):
	self.global_position += velocity * speed * delta

func _dealDamage(entity):
	print(name)
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


func _on_HitboxArea_death():
	queue_free()


func _on_HitboxArea_take_damage(maxHealth, currentHealth):
	$AnimationPlayer.play("Flash")
