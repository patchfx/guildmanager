extends Control

var available_recruits = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	for recruit in GameData.data.npcs:
		if recruit.level == GameData.data.player.guild.renown:
			$AvailableRecruits.add_item(recruit.name)
			available_recruits.push_back(recruit.id)

