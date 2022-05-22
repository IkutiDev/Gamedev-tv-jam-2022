extends KinematicBody2D

const FRICTION = 500
export var Acceleration = 500.0
export var MaxSpeed = 120.0

var velocity = Vector2.ZERO

onready var screenHeight = ProjectSettings.get("display/window/size/height")
onready var collisionHeight = $CollisionShape2D.shape.height  * 2

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	input_vector = input_vector.normalized()
	
	if input_vector.x > 0:
		$Sprite.flip_h = false
	if input_vector.x < 0:
		$Sprite.flip_h = true
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MaxSpeed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	
	if position.y <= 0 + collisionHeight:
		position.y = 0 + collisionHeight
	if position.y >= screenHeight - collisionHeight:
		position.y = screenHeight - collisionHeight
