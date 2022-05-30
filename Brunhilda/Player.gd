extends KinematicBody2D

class_name Player

signal player_took_damage(maxHealth, currentHealth)
signal player_increased_revenge(maxRevenge, currentRevenge)
signal player_has_reborn(portrait)
signal show_player_skills_GUI(skillRowIndex)
signal player_lost

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
export var backgroundProps : PackedScene
export var YSortPath : NodePath
var currentRevenge = 0

var _poisonDamage = 0

var maxRevengeForPhase = 100

var parallaxDistance

var currentParallaxDistance

var currentVector = Vector2.ZERO

onready var healthClass = $HitboxArea as Health
onready var originalMaxSpeed = MaxSpeed

func _enter_tree():
	GameManager.player = self

func _ready():
	var _currentPhase = GameManager.phaseManager.currentPhase as Phase
	maxHealth = _currentPhase.playerHealth
	maxRevengeForPhase = _currentPhase.howMuchRevenge
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
	_spawnProps()


func _bordersCheck():
	if position.y <= border_down:
		position.y = border_down
	if position.y >= border_top:
		position.y = border_top
		
func _spawnProps():
	if global_position.distance_to(Vector2.ZERO) >= currentParallaxDistance-(parallaxDistance/2):
		currentVector.x = currentParallaxDistance
		currentParallaxDistance += parallaxDistance
		var instance = backgroundProps.instance() as YSort
		instance.global_position = currentVector
		instance.add_to_group("Temp")
		get_node(YSortPath).add_child(instance)
		currentVector.x = -currentParallaxDistance
		instance = backgroundProps.instance() as YSort
		instance.global_position = currentVector
		instance.add_to_group("Temp")
		get_node(YSortPath).add_child(instance)
		

func IncreaseRevenge(revenge = 1):
	currentRevenge+=revenge
	currentRevenge = min(currentRevenge, maxRevengeForPhase)
	emit_signal("player_increased_revenge", maxRevengeForPhase, currentRevenge)
	if maxRevengeForPhase == currentRevenge and GameManager.phaseManager.currentPhase.spawnRevenge:
		$HitboxArea.TakeDamage(2)
	if !$CollectAudioPlayer.playing:
		$CollectAudioPlayer.play()
	

func _on_HitboxArea_take_damage(maxHealth, currentHealth):
	emit_signal("player_took_damage",maxHealth, currentHealth)
	if !$ReceiveDmgAudioPlayer.playing:
		$ReceiveDmgAudioPlayer.play()
	$AnimationPlayer.play("Flash")


func _on_HitboxArea_death():
	if currentRevenge < maxRevengeForPhase:
		emit_signal("player_lost")
	else:
		if(phaseIndex >= portraits.size()):
			emit_signal("player_lost")
			return
		Reborn()

func Reborn():
	GameManager.phaseManager.EnterNewPhase()
	var _currentPhase = GameManager.phaseManager.currentPhase as Phase
	maxHealth = _currentPhase.playerHealth
	currentRevenge = 0
	maxRevengeForPhase = _currentPhase.howMuchRevenge
	emit_signal("player_increased_revenge", maxRevengeForPhase, currentRevenge)
	$HitboxArea.FullyRestoreHealth(maxHealth)
	emit_signal("player_took_damage",maxHealth, $HitboxArea.currentHealth)
	emit_signal("player_has_reborn", portraits[phaseIndex])
	$Sprite.texture = sprites[phaseIndex]
	phaseIndex += 1
	if phaseIndex == portraits.size():
		$RebornGhostAudioPlayer.play()
	else:
		$RebornAudioPlayer.play()
	emit_signal("show_player_skills_GUI",_currentPhase.skillRowIndex)
	#pause game and show cool GUI for skills here!
	


func Poison(length, tickTime, poisonDamage):
	$PoisonAnimationPlayer.play("Poison")
	$PoisonTimer.start(length)
	_poisonDamage = poisonDamage
	$PoisonTimerDamageTicks.start(tickTime)
	
func SlowDown(slow):
	MaxSpeed = MaxSpeed / slow
	$SlowTimer.start(5)

func _on_SlowTimer_timeout():
	MaxSpeed = originalMaxSpeed


func _on_PoisonTimer_timeout():
	$PoisonTimerDamageTicks.stop()
	$PoisonAnimationPlayer.stop(true)
	


func _on_PoisonTimerDamageTicks_timeout():
	$HitboxArea.TakeDamage(_poisonDamage)

func _on_CheatMode_add_50_revenge():
	IncreaseRevenge(50)


func _on_CheatMode_decrease_50_hp():
	healthClass.TakeDamage(50)
	emit_signal("player_took_damage",maxHealth, $HitboxArea.currentHealth)



func _on_MenusManager_StartGame():
	emit_signal("show_player_skills_GUI", GameManager.phaseManager.currentPhase.skillRowIndex)
	var parallax = get_node("/root/Game/YSort/ParallaxBackground/ParallaxLayer") as ParallaxLayer
	parallaxDistance = parallax.motion_mirroring.x
	currentParallaxDistance = parallaxDistance
