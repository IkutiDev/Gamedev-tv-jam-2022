extends Node2D

class_name PhaseManager

export (Array, Resource) var phases

export var musicNodePath : NodePath
export var newMusicNodePath : NodePath

var currentPhase

var phaseIndex = 0

func _enter_tree():
	GameManager.phaseManager = self
	EnterNewPhase()

func EnterNewPhase():
	if phaseIndex >= phases.size():
		return
	if phaseIndex == 1:
		var music = get_node(musicNodePath) as AudioStreamPlayer
		music.stop()
		var newMusic = get_node(newMusicNodePath) as AudioStreamPlayer
		newMusic.play()
	currentPhase = phases[phaseIndex]
	GameManager.enemySpawner.EnterPhase(currentPhase)
	phaseIndex += 1
