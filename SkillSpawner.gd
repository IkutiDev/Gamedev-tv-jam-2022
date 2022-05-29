extends Node2D

class_name SkillSpawner

signal skill_has_been_added(icon)

export var bloodTrailScene : PackedScene
export var bloodTrailIcon : Texture
export (Array, Resource) var bloodTrailSkillsNeeded
var bloodTrailTaken = false

export var boneShotgunScene : PackedScene
export var boneShotgunIcon : Texture
export (Array, Resource) var boneShotgunSkillsNeeded
var boneShotgunTaken = false

export var tarrotScene : PackedScene
export var tarrotIcon : Texture
export (Array, Resource) var tarrotSkillsNeeded
var tarrotTaken = false

var skillsTaken : Array

func _enter_tree():
	GameManager.skillSpawner = self

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func AddSkillToPlayer(skill):
	var _skill = skill as Skill
	var skillInstance = _skill.skillScene.instance()
	if _skill.attachAsRemote:
		var remoteTransform = RemoteTransform2D.new()
		remoteTransform.update_rotation = false
		skillInstance.add_to_group("Temp")
		skillInstance.add_to_group("Boner")
		get_tree().get_root().add_child(skillInstance)
		remoteTransform.remote_path = skillInstance.get_path()
		GameManager.player.add_child(remoteTransform)
	else:
		GameManager.player.add_child(skillInstance)
	skillsTaken.append(skill)
	emit_signal("skill_has_been_added", _skill.skillIcon)
	if bloodTrailTaken == false:
		CheckBloodTrail()
	if boneShotgunTaken == false:
		CheckBoneShotgun()
	if tarrotTaken == false:
		CheckTarrot()
	

func CheckBloodTrail():
	var duplicateArray = bloodTrailSkillsNeeded.duplicate()
	for item in skillsTaken:
		var index = duplicateArray.find(item)
		if index >= 0:
			duplicateArray.erase(item)
			
	if duplicateArray.size() == 0:
		var skillInstance = bloodTrailScene.instance()
		GameManager.player.add_child(skillInstance)
		emit_signal("skill_has_been_added", bloodTrailIcon)
		bloodTrailTaken = true
		
func CheckBoneShotgun():
	var duplicateArray = boneShotgunSkillsNeeded.duplicate()
	for item in skillsTaken:
		var index = duplicateArray.find(item)
		if index >= 0:
			duplicateArray.erase(item)
			
	if duplicateArray.size() == 0:
		var skillInstance = boneShotgunScene.instance()
		GameManager.player.add_child(skillInstance)
		emit_signal("skill_has_been_added", boneShotgunIcon)
		boneShotgunTaken = true
		
func CheckTarrot():
	var duplicateArray = tarrotSkillsNeeded.duplicate()
	for item in skillsTaken:
		var index = duplicateArray.find(item)
		if index >= 0:
			duplicateArray.erase(item)
			
	if duplicateArray.size() == 0:
		var skillInstance = tarrotScene.instance()
		GameManager.player.add_child(skillInstance)
		emit_signal("skill_has_been_added", tarrotIcon)
		tarrotTaken = true
