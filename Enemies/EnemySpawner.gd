extends Node2D

class_name EnemySpawner

export var enemiesContainerNodePath : NodePath
export (Array, NodePath) var enemiesSpawnPoints

var visibleEnemies : Array
var currentSpawnPointsIndex = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _enter_tree():
	GameManager.enemySpawner = self

func SpawnEnemy(enemyScene):
	randomize()
	var spawnPoints = enemiesSpawnPoints[currentSpawnPointsIndex]
	var children = get_node(spawnPoints).get_children()
	var position = children[randi() % children.size()].global_position
	var enemyInstance = enemyScene.instance()
	enemyInstance.global_position = position
	get_node(enemiesContainerNodePath).add_child(enemyInstance)
	enemyInstance.Init(self)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_Spawner_Timer_Callback(enemyScene):
	SpawnEnemy(enemyScene)
	pass
	
func EnterPhase(phase):
	ClearOutTimers()
	for enemyConfig in phase.enemiesSpawnRoutine:
		var _enemyConfig = enemyConfig as EnemiesConfig
		for i in _enemyConfig.spawnerCounter:
			var timer = Timer.new()
			timer.set_one_shot(false)
			timer.set_wait_time(_enemyConfig.spawnRate)
			timer.connect("timeout", self, "_on_Spawner_Timer_Callback", [_enemyConfig.enemyScene])
			$Timers.add_child(timer)
			timer.start()


func ClearOutTimers():
	for timer in $Timers.get_children():
		timer.queue_free()


