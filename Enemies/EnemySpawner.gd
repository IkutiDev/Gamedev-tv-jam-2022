extends Node2D

class_name EnemySpawner

export var enemiesContainerNodePath : NodePath
export var bossScene : PackedScene
export var bossSpawnPoint : NodePath

var visibleEnemies : Array
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _enter_tree():
	GameManager.enemySpawner = self

func SpawnEnemy(enemyScene):
	randomize()
	var children = $SpawnPoints.get_children()
	var index = randi() % children.size()
	var startIndex = index
	var spawnPoint = children[index] as SpawnPosition
	if spawnPoint.isBusy:
		while(spawnPoint.isBusy):
			index +=1
			if index == startIndex:
				return
			if index >= children.size():
				index = 0
			spawnPoint = children[index] as SpawnPosition
	spawnPoint.Spawn()
	var enemyInstance = enemyScene.instance()
	enemyInstance.global_position = spawnPoint.global_position
	get_node(enemiesContainerNodePath).add_child(enemyInstance)
	enemyInstance.Init(self)
	
func SpawnBoss():
	var bossInstance = bossScene.instance()
	bossInstance.global_position = get_node(bossSpawnPoint).global_position
	get_node(enemiesContainerNodePath).add_child(bossInstance)
	bossInstance.Init(self)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func _process(delta):
	print(visibleEnemies.size())
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
			
	var _phase = phase as Phase
	if _phase.spawnBoss :
		SpawnBoss()

func ClearOutTimers():
	for timer in $Timers.get_children():
		timer.queue_free()


