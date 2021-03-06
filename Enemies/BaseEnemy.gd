extends KinematicBody2D

class_name BaseEnemy

var playerNode : Node2D
var playerPosition : Vector2

export var revengeOrb : PackedScene

const FRICTION = 500
export var Acceleration = 500.0
export var enemySpeed = 120.0
export var cowardMovement = false
export var cowardMovementMaxDistance = 10

export var enemyDamage = 0.2
export var enemyDamageSpeed = 0.2
export var maxHealth = 100.0

export var isBoss = false
export var AuraDuration = 5.0
export var AuraCooldown = 10.0

var velocity = Vector2.ZERO

var knockback_state = false
var poison_state = false
var _poisonDamage = 5

var _enemySpawner : EnemySpawner

onready var _originalSpeed = enemySpeed

func Init(enemySpawner):
	_enemySpawner = enemySpawner as EnemySpawner
	var players = get_tree().get_nodes_in_group("player")
	playerNode = players[0]
	playerPosition = playerNode.global_position
	$HitboxArea.Init(maxHealth)
	$DamageDealer.Init(self)
	
	if isBoss:
		EnableAura()

func _process(delta):
	
	playerPosition = playerNode.global_position
	
	var direction_vector = Vector2.ZERO
	direction_vector = global_position.direction_to(playerPosition).normalized()
	
	
	if isBoss:
		if direction_vector.x > 0:
			scale.x = scale.y * -1
		if direction_vector.x < 0:
			scale.x = scale.y * 1		
	else:
		if direction_vector.x > 0:
			scale.x = scale.y * 1
		if direction_vector.x < 0:
			scale.x = scale.y * -1

	
	if(cowardMovement):
		if(global_position.distance_to(playerPosition))<= cowardMovementMaxDistance:
			direction_vector = -direction_vector

	if direction_vector != Vector2.ZERO:
		velocity = velocity.move_toward(direction_vector * enemySpeed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if global_position.distance_to(playerPosition) <= 0.05:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)
	

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	_enemySpawner.visibleEnemies.erase(self)
	if isBoss:
		return
	if $VisibilityNotifier2D/Timer.is_inside_tree():
		$VisibilityNotifier2D/Timer.start()

func DestroyThisEnemy(killedByPlayer, killedByCards = false):
	if killedByPlayer:
		if killedByCards and isBoss:
			return
		var GUI = get_tree().get_nodes_in_group("GUI")[0] as GUI
		GUI.UpdateKillCounter()
		randomize()
		if randi() % 10 > 0 and GameManager.phaseManager.currentPhase.spawnRevenge:
			var revengeOrbInstance = revengeOrb.instance()
			revengeOrbInstance.global_position = global_position
			revengeOrbInstance.add_to_group("Temp")
			get_tree().get_root().call_deferred("add_child", revengeOrbInstance)
	_enemySpawner.visibleEnemies.erase(self)
	if isBoss:
		var MenuManager = get_tree().get_nodes_in_group("MenuManager")[0] as MenuManager
		MenuManager.ShowWinScreen()
	queue_free()


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	_enemySpawner.visibleEnemies.append(self)
	if isBoss:
		return
	if !$VisibilityNotifier2D/Timer.is_stopped():
		$VisibilityNotifier2D/Timer.stop()
	
func _on_Timer_timeout():
	DestroyThisEnemy(false)


func _on_HitboxArea_death():
	DestroyThisEnemy(true)
	
func Poison(length, tickTime, poisonDamage):
	$PoisonAnimationPlayer.play("Poison")
	$PoisonTimer.start(length)
	_poisonDamage = poisonDamage
	$PoisonTimerDamageTicks.start(tickTime)
	
func SlowDown(slow):
	enemySpeed = enemySpeed / slow
	$SlowTimer.start(5)


func _on_HitboxArea_take_damage(maxHealth, currentHealth):
	if isBoss:
		print(currentHealth)
	$AnimationPlayer.play("Flash")


func _on_SlowTimer_timeout():
	enemySpeed = _originalSpeed


func _on_PoisonTimer_timeout():
	$PoisonTimerDamageTicks.stop()
	$PoisonAnimationPlayer.stop(true)
	


func _on_PoisonTimerDamageTicks_timeout():
	$HitboxArea.TakeDamage(_poisonDamage)
	
func EnableAura():
	$RetributionAura.set_process(false)
	$RetributionAura.hide()
	$AuraStartTimer.start(AuraCooldown)


func _on_AuraStartTimer_timeout():
	$RetributionAura.set_process(true)
	$RetributionAura.show()
	$AuraEndTimer.start(AuraDuration)

func _on_AuraEndTimer_timeout():
	$RetributionAura.set_process(false)
	$RetributionAura.hide()
	$AuraStartTimer.start(AuraCooldown)
