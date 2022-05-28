extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var damage = 30
export var movementSpeed = 25

var entityHealth : Health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	$Path2D/PathFollow2D.offset += movementSpeed * delta
	if $Path2D/PathFollow2D.unit_offset >= 1:
		queue_free()


func _on_Area2D_area_entered(area):
	if area is Health:
		_dealDamage(area)
		
func _dealDamage(entity):
	entityHealth = entity
	entityHealth.TakeDamage(damage)
