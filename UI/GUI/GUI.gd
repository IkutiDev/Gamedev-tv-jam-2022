extends Control

class_name GUI

var killCounter = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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
		$ExpBarFilling.value = 1
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
