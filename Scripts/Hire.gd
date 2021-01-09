extends Control

var available_recruits = []
var selected_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	available_recruits = []
	for id in GameData.data.npcs:
		var recruit = GameData.data.npcs[id]
		if recruit.level == GameData.data.player.guild.renown:
			$AvailableRecruits.add_item(recruit.name)
			available_recruits.push_back(recruit.id)

func update_ui():
	pass

func _on_AvailableRecruits_item_selected(index):
	selected_index = index
	var recruit_id = available_recruits[index]
	
	for id in GameData.data.npcs:
		if id == recruit_id:
			var recruit = GameData.data.npcs[id]
			$CharacterName.text = recruit.name.to_upper()
			$MightStat.text = str(recruit.might)
			$ReflexStat.text = str(recruit.reflex)
			$MindStat.text = str(recruit.mind)
			$ConstitutionStat.text = str(recruit.constitution)
			$CharismaStat.text = str(recruit.charisma)
			$LevelStat.text = str(recruit.level)
			
			var hire_cost = _hire_cost_for(recruit)
			$HireCost.text = str(hire_cost) + "g"
			if GameData.data.player.gold < hire_cost:
				$HireRecruit.disabled = true
				$HireRecruit.hint_tooltip = "Insufficient Gold"
			else:
				$HireRecruit.disabled = false
				$HireRecruit.hint_tooltip = "Hire Recruit"


func _on_HireRecruit_button_up():
	var recruit_id = available_recruits[selected_index]
	for id in GameData.data.npcs:
		if id == recruit_id:
			var recruit = GameData.data.npcs[id]
			var hire_cost = _hire_cost_for(recruit)
			GameData.data.player.guild.recruits.push_back(id)
			GameData.data.player.gold -= hire_cost

func _hire_cost_for(recruit):
	var total_stats = recruit.might + recruit.reflex + recruit.mind + recruit.constitution + recruit.charisma
	var hire_cost = total_stats / 10 * recruit.level
	return(hire_cost)
