extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var whipCooldown = 2.0

export var damage = 10

var entityHealth : Health


# Called when the node enters the scene tree for the first time.
func _ready():
	_enableWhip()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _enableWhip():
	$AudioStreamPlayer.play()
	$AnimatedSprite.play()
	$WhipArea2D/WhipCollision.disabled = false
	
func _disableWhip():
	$AnimatedSprite.stop()
	$WhipArea2D/WhipCollision.disabled = true
	$WhipCooldownTimer.start(whipCooldown)


func _on_WhipDisableTimer_timeout():
	_disableWhip()


func _on_WhipCooldownTimer_timeout():
	_enableWhip()
	
func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)

func _on_WhipArea2D_area_entered(area):
	if area is Health:
		_dealDamage(area)


func _on_AnimatedSprite_animation_finished():
	_disableWhip()
