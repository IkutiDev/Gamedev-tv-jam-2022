extends KinematicBody2D

var playerNode : Node2D
var playerPosition : Vector2

const FRICTION = 500
export var Acceleration = 500.0
export var enemySpeed = 120.0

var velocity = Vector2.ZERO

var currentTimer : Timer

export var health = 100

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

	if direction_vector != Vector2.ZERO:
		velocity = velocity.move_toward(direction_vector * enemySpeed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if global_position.distance_to(playerPosition) <= 0.05:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)
	

func TakeDamage(damage):
	health -= damage





func _on_VisibilityNotifier2D_viewport_exited(viewport):
	currentTimer = Timer.new()
	currentTimer.connect("timeout",self,"DestroyWhenNotVisible") 
#timeout is what says in docs, in signals
#self is who respond to the callback
#_on_timer_timeout is the callback, can have any name
	add_child(currentTimer) #to process
	currentTimer.start(5.0) #to start
	
func DestroyWhenNotVisible():
	queue_free()


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	if currentTimer:
		currentTimer.stop()
