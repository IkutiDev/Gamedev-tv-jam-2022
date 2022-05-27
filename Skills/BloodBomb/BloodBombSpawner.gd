extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var bloodBombScene : PackedScene

export var weaponCooldown = 4.0

var enemySpawner : EnemySpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	enemySpawner = GameManager.enemySpawner as EnemySpawner
	$Timer.start(weaponCooldown)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var bloodBombInstance = bloodBombScene.instance() as BloodBomb
	randomize()
	var enemy = enemySpawner.visibleEnemies[randi() % enemySpawner.visibleEnemies.size()] as BaseEnemy
	bloodBombInstance.Init(enemy)
	bloodBombInstance.global_position = global_position
	get_tree().get_root().add_child(bloodBombInstance)
