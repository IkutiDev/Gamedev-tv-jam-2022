extends KinematicBody2D

class_name Player

signal player_took_damage(maxHealth, currentHealth)
signal player_increased_revenge(maxRevenge, currentRevenge)
signal player_has_reborn(portrait)

#Movement
const FRICTION = 500
export var portraits : Array
export var sprites : Array
export var maxHealth = 100
var phaseIndex = 0
export var Acceleration = 500.0
export var MaxSpeed = 120.0
var velocity = Vector2.ZERO
#Borders
export var border_top = 540
export var border_down = -180

var currentRevenge = 0

var maxRevengeForPhase = 100

onready var healthClass = $HitboxArea as Health

func _enter_tree():
	GameManager.player = self

func _ready():
	$HitboxArea.Init(maxHealth)

func _physics_process(delta):
	_movement(delta)
	_bordersCheck()
	
func _movement(delta):
	var input_vector = Vector2.ZERO
	input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	input_vector = input_vector.normalized()
	
	if input_vector.x > 0:
		scale.x = scale.y * 1
	if input_vector.x < 0:
		scale.x = scale.y * -1
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MaxSpeed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

func _bordersCheck():
	if position.y <= border_down:
		position.y = border_down
	if position.y >= border_top:
		position.y = border_top
		

func IncreaseRevenge(revenge = 1):
	currentRevenge+=revenge
	emit_signal("player_increased_revenge", maxRevengeForPhase, currentRevenge)
	

func _on_HitboxArea_take_damage(maxHealth, currentHealth):
	emit_signal("player_took_damage",maxHealth, currentHealth)
	$AnimationPlayer.play("Flash")


func _on_HitboxArea_death():
	if currentRevenge < maxRevengeForPhase:
		print("You lost lol")
	else:
		Reborn()

func Reborn():
	currentRevenge = 0
	maxRevengeForPhase = maxRevengeForPhase * 2
	emit_signal("player_increased_revenge", maxRevengeForPhase, currentRevenge)
	$HitboxArea.FullyRestoreHealth()
	emit_signal("player_took_damage",maxHealth, $HitboxArea.currentHealth)
	emit_signal("player_has_reborn", portraits[phaseIndex])
	$Sprite.texture = sprites[phaseIndex]
	#pause game and show cool GUI for skills here!
	phaseIndex += 1


func _on_CheatMode_add_50_revenge():
	IncreaseRevenge(50)


func _on_CheatMode_decrease_50_hp():
	healthClass.TakeDamage(50)
	emit_signal("player_took_damage",healthClass.maxHealth, healthClass.health)
