extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var rowOneNodePath : NodePath
export var rowTwoNodePath : NodePath
export var rowThreeNodePath : NodePath

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func HideSkillSelectMenu():
	get_tree().paused = false
	hide()

func SelectSkill(skill):
	GameManager.skillSpawner.AddSkillToPlayer(skill)
	HideSkillSelectMenu()


func _on_GUI_ShowSkillMenu(skillRowIndex):
	get_tree().paused = true
	var rowOne = get_node(rowOneNodePath) as SkillRow
	var rowTwo = get_node(rowTwoNodePath) as SkillRow
	var rowThree = get_node(rowThreeNodePath) as SkillRow
	var skillsTaken = GameManager.skillSpawner.skillsTaken
	rowOne.DisableSkills(skillsTaken)
	rowTwo.DisableSkills(skillsTaken)
	rowThree.DisableSkills(skillsTaken)
	
	
	if skillRowIndex == 0:
		rowOne.show()
		rowTwo.hide()
		rowThree.hide()
	if skillRowIndex == 1:
		rowOne.hide()
		rowTwo.show()
		rowThree.hide()
	if skillRowIndex == 2:
		rowOne.hide()
		rowTwo.hide()
		rowThree.show()
	if skillRowIndex == 3:
		rowOne.show()
		rowTwo.show()
		rowThree.show()
	show()


func _on_Row1_SkillSelected(skill):
	SelectSkill(skill)


func _on_Row2_SkillSelected(skill):
	SelectSkill(skill)


func _on_Row3_SkillSelected(skill):
	SelectSkill(skill)
