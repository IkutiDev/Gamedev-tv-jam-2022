extends Node2D



export var boneScene : PackedScene
export var cooldown = 5.0
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
	var children = get_node("SpawnPositions").get_children() as Array
	for i in get_node("SpawnPositions").get_child_count():
		SpawnBone(children[i])
		
func SpawnBone(spawnPosition):
	var _spawnPosition = spawnPosition as Position2D
	var boneInstance = boneScene.instance() as Bone
	boneInstance.global_position = _spawnPosition.global_position
	boneInstance.rotation = _spawnPosition.rotation
	get_tree().get_root().add_child(boneInstance)
