extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var bloodPoolScene :  PackedScene
export var cooldown = 0.5

var currentTimer = 0.0
var _player : Player
var _playerPosition = Vector2.ZERO
var _lastPlayerPosition = Vector2.ZERO
var spawnEnabled = false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	_player = GameManager.player as Player
	_playerPosition = _player.global_position
	spawnEnabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !spawnEnabled:
		return
	
	_lastPlayerPosition = _playerPosition
	_playerPosition = _player.global_position
	currentTimer += delta
	
	if currentTimer >= cooldown and _lastPlayerPosition != _playerPosition:
		currentTimer = 0.0
		SpawnBloodPool()

func SpawnBloodPool():
	var bloodPoolInstance = bloodPoolScene.instance() as BloodPool
	bloodPoolInstance.global_position = global_position
	bloodPoolInstance.add_to_group("Temp")
	get_tree().get_root().add_child(bloodPoolInstance)
