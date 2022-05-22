extends Node2D

export var enemiesContainerNodePath : NodePath
export(PackedScene) var enemy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func SpawnEnemy():
	randomize()
	var children = $SpawnPoints.get_children()
	var position = children[randi() % children.size()].global_position
	var enemyInstance = enemy.instance()
	enemyInstance.global_position = position
	get_node(enemiesContainerNodePath).add_child(enemyInstance)
	enemyInstance.Init()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Timer_timeout():
	SpawnEnemy()
