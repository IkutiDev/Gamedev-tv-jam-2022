extends KinematicBody2D


#Movement
const FRICTION = 500
export var Acceleration = 500.0
export var MaxSpeed = 120.0
var velocity = Vector2.ZERO
#Borders
export var border_top = 540
export var border_down = -180

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
		

