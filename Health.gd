extends Area2D

class_name Health

signal death
signal take_damage(maxHealth, currentHealth)

var currentHealth = 0

var _maxHealth = 0

func Init(maxHealth):
	_maxHealth = maxHealth
	currentHealth = _maxHealth

func FullyRestoreHealth(maxHealth):
	_maxHealth = maxHealth
	currentHealth = _maxHealth

func TakeDamage(damage):
	currentHealth -= damage
	if currentHealth <= 0:
		emit_signal("death")
	else:
		emit_signal("take_damage", _maxHealth, currentHealth)
