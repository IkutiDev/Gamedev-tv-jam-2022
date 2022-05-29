extends Control

class_name GUI

signal ShowSkillMenu(skillRowIndex)

var killCounter = 0

export (Array, NodePath) var skillIcons
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


func _on_SkillSpawner_skill_has_been_added(icon):
	var skillIcon = get_node(skillIcons[skillIconIndex]) as SkillIcon
	skillIcon.ShowIcon(icon)
	skillIconIndex += 1


func _on_Player_show_player_skills_GUI(skillRowIndex):
	emit_signal("ShowSkillMenu", skillRowIndex)


func _on_MenusManager_ShowGUI():
	show()


func _on_MenusManager_HideGUI():
	hide()
