extends Node2D

class_name EnemySpawner

export var enemiesContainerNodePath : NodePath
export var townsfolkScene : PackedScene
export var militiaScene : PackedScene
export var priestScene : PackedScene
export var knightScene : PackedScene
export var BossScene : PackedScene

var visibleEnemies : Array
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _enter_tree():
	GameManager.enemySpawner = self

func SpawnEnemy(enemyScene):
	randomize()
	var children = $SpawnPoints.get_children()
	var position = children[randi() % children.size()].global_position
	var enemyInstance = enemyScene.instance()
	enemyInstance.global_position = position
	get_node(enemiesContainerNodePath).add_child(enemyInstance)
	enemyInstance.Init(self)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_TownsFolkTimer_timeout():
	SpawnEnemy(townsfolkScene)
	pass


func _on_MilitiaTimer_timeout():
	SpawnEnemy(militiaScene)
	pass


func _on_PriestTimer_timeout():
	SpawnEnemy(priestScene)
	pass # Replace with function body.


func _on_KnightTimer_timeout():
	SpawnEnemy(knightScene)
	pass # Replace with function body.
