extends KinematicBody2D

class_name BaseEnemy

var playerNode : Node2D
var playerPosition : Vector2

const FRICTION = 500
export var Acceleration = 500.0
export var enemySpeed = 120.0

var velocity = Vector2.ZERO

var knockback_state = false

func Init():
	var players = get_tree().get_nodes_in_group("player")
	playerNode = players[0]
	playerPosition = playerNode.global_position

func _process(delta):
	
	playerPosition = playerNode.global_position
	
	var direction_vector = Vector2.ZERO
	direction_vector = global_position.direction_to(playerPosition).normalized()
	
	
	if direction_vector.x > 0:
		$Sprite.flip_h = false
	if direction_vector.x < 0:
		$Sprite.flip_h = true
	
	if knockback_state:
		direction_vector = -direction_vector


	if direction_vector != Vector2.ZERO:
		velocity = velocity.move_toward(direction_vector * enemySpeed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if global_position.distance_to(playerPosition) <= 0.05:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	if $VisibilityNotifier2D/Timer.is_inside_tree():
		$VisibilityNotifier2D/Timer.start()

func DestroyThisEnemy(killedByPlayer):
	if killedByPlayer:
		print("LOOTZ!")
	queue_free()


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	if !$VisibilityNotifier2D/Timer.is_stopped():
		$VisibilityNotifier2D/Timer.stop()
	
func _on_Timer_timeout():
	DestroyThisEnemy(false)


func _on_HitboxArea_death():
	DestroyThisEnemy(true)


func _on_HitboxArea_take_damage():
	knockback_state = true
	$KnockbackTimer.start(0.5)
	$AnimationPlayer.play("Flash")


func _on_KnockbackTimer_timeout():
	knockback_state = false
