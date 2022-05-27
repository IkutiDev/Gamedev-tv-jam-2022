extends Node2D

class_name BoneSmall

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
	queue_free()
		

func SelfDestruct():
	queue_free()


func _on_Timer_timeout():
	SelfDestruct()
