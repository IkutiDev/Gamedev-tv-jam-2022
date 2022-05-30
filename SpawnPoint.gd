extends Position2D

class_name SpawnPosition

var busyTime = 3
var isBusy = false

func Spawn():
	isBusy = true
	$Timer.start(busyTime)
	



func _on_Timer_timeout():
	isBusy= false
