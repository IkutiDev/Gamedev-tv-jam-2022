extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var damageEffectSprite : Texture
export var poisonEffectSprite : Texture
export var slowEffectSprite : Texture

export var minCooldown = 15.0
export var maxCooldown = 30.0

export var poisonDamage = 5
export var poisonLength = 10
export var poisonTickRate = 0.5

export var slowModifier = 4.0

export var badLuckChanceInPercenatage = 100.0

export var badLuckDamage = 50

var random = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	$Timer.start(random.randf_range(minCooldown, maxCooldown))
	pass # Replace with function body.
	
	
func SpawnEffect():
	$GoodLuckAudio.play()
	randomize()
	
	var number = randi() % 3
	
	if number == 0:
		DamageEffect()
		pass
	elif number == 1:
		DamageEffect()
	else:
		DamageEffect()

func DamageEffect():
	$CanvasLayer/TextureRect.texture = damageEffectSprite
	get_tree().call_group("Boner", "queue_free")
	for i in GameManager.enemySpawner.visibleEnemies:
		var enemy = i as BaseEnemy
		enemy.DestroyThisEnemy(true, true)

func PoisonEffect():
	$CanvasLayer/TextureRect.texture = poisonEffectSprite
	for item in GameManager.enemySpawner.visibleEnemies:
		if GameManager.enemySpawner.visibleEnemies.size() == 0:
			return
		var enemy = item as BaseEnemy
		enemy.Poison(poisonLength, poisonTickRate, poisonDamage)


func SlowEffect():
	$CanvasLayer/TextureRect.texture = slowEffectSprite
	for item in GameManager.enemySpawner.visibleEnemies:
		if GameManager.enemySpawner.visibleEnemies.size() == 0:
			return		
		var enemy = item as BaseEnemy
		enemy.SlowDown(slowModifier)

func BadEffect():
	$BadLuckAudio.play()
	randomize()
	
	var number = randi() % 3
	
	if number == 0:
		BadDamageEffect()
	elif number == 1:
		BadPoisonEffect()
	else:
		BadSlowEffect()

func BadDamageEffect():
	$CanvasLayer/TextureRect.texture = damageEffectSprite
	GameManager.player.healthClass.TakeDamage(badLuckDamage)
	
func BadPoisonEffect():
	$CanvasLayer/TextureRect.texture = poisonEffectSprite
	GameManager.player.Poison(poisonLength, poisonTickRate, poisonDamage)
	
func BadSlowEffect():
	$CanvasLayer/TextureRect.texture = slowEffectSprite
	GameManager.player.SlowDown(slowModifier)

func _on_Timer_timeout():
	$AnimationPlayer.play("Blink")
	randomize()
	
	var badLuckChance = 100 / badLuckChanceInPercenatage as int
	
	var number = randi() % badLuckChance
	if number == 0:
		BadEffect()
	else:
		SpawnEffect()
	random.randomize()
	$Timer.start(random.randf_range(minCooldown, maxCooldown))
