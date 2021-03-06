extends TextureRect

class_name SkillRow

signal SkillSelected(skill)

export var _skill : Resource
export var _skill2 : Resource

export var Skill1IconPath : NodePath
export var Skill2IconPath : NodePath
export var Skill1Button : NodePath
export var Skill2Button : NodePath
export var SkillDescriptionLabelPath : NodePath
export var SkillTitleLabelPath : NodePath

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var skill1Icon = get_node(Skill1IconPath) as TextureRect
	skill1Icon.texture = _skill.skillIcon
	var skill2Icon = get_node(Skill2IconPath) as TextureRect
	skill2Icon.texture = _skill2.skillIcon


func DisableSkills(skillsTaken):
	for item in skillsTaken:
		if _skill == item:
			var button = get_node(Skill1Button) as TextureButton
			button.disabled = true
			button.modulate = Color(1,1,1,0.1)
		if _skill2 == item:
			var button = get_node(Skill2Button) as TextureButton
			button.disabled = true
			button.modulate = Color(1,1,1,0.1)

func _on_SkillButton_pressed():
	emit_signal("SkillSelected", _skill)


func _on_SkillButton2_pressed():
	emit_signal("SkillSelected", _skill2)


func _on_SkillButton_mouse_entered():
	var labelDescription = get_node(SkillDescriptionLabelPath) as Label
	var labelTitle = get_node(SkillTitleLabelPath) as Label
	labelDescription.text = _skill.skillDescription
	labelTitle.text = _skill.skillTitle


func _on_SkillButton2_mouse_entered():
	var labelDescription = get_node(SkillDescriptionLabelPath) as Label
	var labelTitle = get_node(SkillTitleLabelPath) as Label
	labelDescription.text = _skill2.skillDescription
	labelTitle.text = _skill2.skillTitle
