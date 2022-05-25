extends Area2D

class_name Health

signal death
signal take_damage(maxHealth, currentHealth)

export var health = 100.0

onready var maxHealth = health

func TakeDamage(damage):
	health -= damage
	if health <= 0:
		emit_signal("death")
	else:
		emit_signal("take_damage", maxHealth, health)
