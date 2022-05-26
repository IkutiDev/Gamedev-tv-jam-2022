extends Node2D

class_name EnemySpawner

export var enemiesContainerNodePath : NodePath
export(PackedScene) var enemy

var visibleEnemies : Array
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _enter_tree():
	GameManager.enemySpawner = self

func SpawnEnemy():
	randomize()
	var children = $SpawnPoints.get_children()
	var position = children[randi() % children.size()].global_position
	var enemyInstance = enemy.instance()
	enemyInstance.global_position = position
	get_node(enemiesContainerNodePath).add_child(enemyInstance)
	enemyInstance.Init(self)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Timer_timeout():
	SpawnEnemy()
