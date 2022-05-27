extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var cooldown = 3.0
export var damageSpeed = 0.5
export var damage = 10

var currentTimer = 0.0
var enemies : Array
var entityHealth : Health
var lastTick = false
onready var startRotation = rotation_degrees
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.hide()
	$AnimatedSprite.set_process(false)
	$Timer.start(cooldown)

func StartClockCooldown():
	$AnimatedSprite.hide()
	$AnimatedSprite.set_process(false)
	lastTick = false
	$Timer.start(cooldown)

func _process(delta):
	if enemies.size() == 0:
		return
	currentTimer += delta
	if currentTimer > damageSpeed:
		currentTimer = 0.0
		for i in enemies.size():
			_dealDamage(enemies[i])

func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)


func _on_Timer_timeout():
	$AnimatedSprite.show()
	$AnimatedSprite.set_process(true)
	$ClockTurningTimer.start(1)


func _on_ClockTurningTimer_timeout():
	if lastTick:
		$ClockTurningTimer.stop()
		StartClockCooldown()
		return
	rotation_degrees += 30
	if rotation_degrees as int == startRotation as int:
		lastTick = true



func _on_Area2D_area_entered(area):
	if area is Health:
		enemies.append(area)
		_dealDamage(area)


func _on_Area2D_area_exited(area):
	enemies.erase(area)
