extends Node2D

class_name BoomerangSpawner

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var boomerangScene : PackedScene
export var cooldown = 6.0

var enemySpawner : EnemySpawner
var player : Player
# Called when the node enters the scene tree for the first time.
func _ready():
	enemySpawner = GameManager.enemySpawner as EnemySpawner
	player = GameManager.player as Player
	$Timer.start(cooldown)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var boomerangInstance = boomerangScene.instance() as Boomerang
	randomize()
	var enemy = enemySpawner.visibleEnemies[randi() % enemySpawner.visibleEnemies.size()] as BaseEnemy
	boomerangInstance.Init(enemy, player)
	boomerangInstance.global_position = global_position
	get_tree().get_root().add_child(boomerangInstance)
