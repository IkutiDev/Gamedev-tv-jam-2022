extends Node2D



export var boneScene : PackedScene
export var cooldown = 5.0
export var projectileCount = 5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(cooldown)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	BoneExplosion()
	
func BoneExplosion():
	$AudioStreamPlayer.play()
	var duplicateEnemiesArray = GameManager.enemySpawner.visibleEnemies
	for i in projectileCount:
		randomize()
		if duplicateEnemiesArray.size() == 0:
			return
		var index = randi() % duplicateEnemiesArray.size()
		var enemy = duplicateEnemiesArray[index]
		duplicateEnemiesArray.erase(enemy)
		SpawnBone(enemy)
		
func SpawnBone(enemy):
	var boneInstance = boneScene.instance() as Bone
	boneInstance.global_position = global_position
	boneInstance.Init(enemy)
	get_tree().get_root().add_child(boneInstance)
