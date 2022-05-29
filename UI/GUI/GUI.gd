extends Control

class_name GUI

var killCounter = 0

export (Array, NodePath) var skillIcons
export var skillSelectMenuPath : NodePath
var skillIconIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$KillCountLabel.text = killCounter as String
	UpdateHealthBar(1,1)
	
func UpdateKillCounter():
	killCounter+=1
	$KillCountLabel.text = killCounter as String

func UpdateHealthBar(maxHealth, currentHealth):
	$HPBarFilling.value = (currentHealth / maxHealth * 100) as int

func UpdateRevengeBar(maxRevenge, currentRevenge):
	if maxRevenge == 0:
		$ExpBarFilling.value = 100
	else:
		$ExpBarFilling.value = (currentRevenge as float / maxRevenge * 100) as int

func UpdatePortrait(currentPortait):
	$CharacterPortrait.texture = currentPortait as Texture


func _on_Player_player_took_damage(maxHealth, health):
	UpdateHealthBar(maxHealth, health)


func _on_Player_player_increased_revenge(maxRevenge, currentRevenge):
	UpdateRevengeBar(maxRevenge, currentRevenge)


func _on_Player_player_has_reborn(portrait):
	UpdatePortrait(portrait)
	
func ShowSkillSelectMenu():
	get_tree().paused = true
	get_node(skillSelectMenuPath).show()


func _on_SkillSpawner_skill_has_been_added(icon):
	var skillIcon = get_node(skillIcons[skillIconIndex]) as SkillIcon
	skillIcon.ShowIcon(icon)
	skillIconIndex += 1


func _on_Player_show_player_skills_GUI(skillsAlreadyTaken):
	ShowSkillSelectMenu()


func _on_MenusManager_StartGame():
	show()

func SelectSkill(skill):
	GameManager.skillSpawner.AddSkillToPlayer(skill)
	HideSkillSelectMenu()
	
func HideSkillSelectMenu():
	get_tree().paused = false
	get_node(skillSelectMenuPath).hide()

func _on_Row1_SkillSelected(skill):
	SelectSkill(skill)


func _on_Row2_SkillSelected(skill):
	SelectSkill(skill)


func _on_Row3_SkillSelected(skill):
	SelectSkill(skill)
