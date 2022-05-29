extends Node2D

class_name SkillSpawner

signal skill_has_been_added(icon)

func _enter_tree():
	GameManager.skillSpawner = self

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func AddSkillToPlayer(skill):
	var _skill = skill as Skill
	var skillInstance = _skill.skillScene.instance()
	GameManager.player.add_child(skillInstance)
	emit_signal("skill_has_been_added", _skill.skillIcon)
