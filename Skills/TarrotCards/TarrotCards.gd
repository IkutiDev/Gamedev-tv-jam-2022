extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var damageEffectSprite : Texture
export var poisonEffectSprite : Texture
export var slowEffectSprite : Texture

export var minCooldown = 15.0
export var maxCooldown = 30.0

var random = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	$Timer.start(random.randf_range(minCooldown, maxCooldown))
	pass # Replace with function body.
	
	
func SpawnEffect():
	randomize()
	
	var number = randi() % 3
	
	if number == 0:
		DamageEffect()
	elif number == 1:
		PoisonEffect()
	else:
		SlowEffect()

func DamageEffect():
	$Image.texture = damageEffectSprite
	for item in GameManager.enemySpawner.visibleEnemies:
		var enemy = item as BaseEnemy
		enemy.DestroyThisEnemy(true)

func PoisonEffect():
	$Image.texture = poisonEffectSprite
	for item in GameManager.enemySpawner.visibleEnemies:
		var enemy = item as BaseEnemy
		enemy.DestroyThisEnemy(true)

func SlowEffect():
	$Image.texture = slowEffectSprite
	for item in GameManager.enemySpawner.visibleEnemies:
		var enemy = item as BaseEnemy
		enemy.SlowDown()

func _on_Timer_timeout():
	$AnimationPlayer.play("Blink")
	SpawnEffect()
	random.randomize()
	$Timer.start(random.randf_range(minCooldown, maxCooldown))
