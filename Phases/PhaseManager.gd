extends Node2D

class_name PhaseManager

export (Array, Resource) var phases

var currentPhase

var phaseIndex = 0

func _enter_tree():
	GameManager.phaseManager = self
	EnterNewPhase()

func EnterNewPhase():
	if phaseIndex >= phases.size():
		return
	currentPhase = phases[phaseIndex]
	GameManager.enemySpawner.EnterPhase(currentPhase)
	phaseIndex += 1
