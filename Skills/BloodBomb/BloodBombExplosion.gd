extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var length = 4.0
export var speed = 0.5
export var damage = 10
var enemies : Array
var entityHealth : Health

var currentTimer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(length)


func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)

func _process(delta):
	if enemies.size() == 0:
		return
	currentTimer += delta
	if currentTimer > speed:
		currentTimer = 0.0
		for i in enemies.size():
			_dealDamage(enemies[i])

func _on_Area2D_area_entered(area):
	if area is Health:
		enemies.append(area)


func _on_Area2D_area_exited(area):
	enemies.erase(area)

func _on_Timer_timeout():
	queue_free()
