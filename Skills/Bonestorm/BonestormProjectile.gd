extends Node2D

class_name Bone

export var SmallBoneScene : PackedScene
export var speed = 10
export var damage = 10
export var selfDestructTime = 10

var entityHealth : Health

func _ready():
	$Timer.start(selfDestructTime)

func _process(delta):
	self.translate((self.transform.y.normalized() + self.transform.x.normalized()) * speed * delta)

func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)

func _on_Area2D_area_entered(area):
	var health = area as Health
	if health == null:
		return
	_dealDamage(area)
	BoneExplosion()
	queue_free()
		
func BoneExplosion():
	var children = get_node("SpawnPositions").get_children() as Array
	for i in get_node("SpawnPositions").get_child_count():
		SpawnSmallBone(children[i])
		
func SpawnSmallBone(spawnPosition):
	var _spawnPosition = spawnPosition as Position2D
	var smallBoneInstance = SmallBoneScene.instance() as BoneSmall
	smallBoneInstance.global_position = _spawnPosition.global_position
	smallBoneInstance.rotation = _spawnPosition.rotation
	get_tree().get_root().call_deferred("add_child", smallBoneInstance)

func SelfDestruct():
	queue_free()


func _on_Timer_timeout():
	queue_free()
