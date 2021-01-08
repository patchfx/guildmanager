extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


func update_ui():
	var guild = GameData.data.player.guild
	$GuildOverview/GuildName.text = guild.name.to_upper()
	
	if guild.renown <= 1:
		$GuildOverview/GuildRenown.text = "RENOWN: UNKNOWN"
	elif guild.renown <= 5:
		$GuildOverview/GuildRenown.text = "RENOWN: KNOWN"
	elif guild.renown <= 10:
		$GuildOverview/GuildRenown.text = "RENOWN: RESPECTED"
	elif guild.renown <= 15:
		$GuildOverview/GuildRenown.text = "RENOWN: REVERED"

	$GuildOverview/CompletedQuests.text = "COMPLETED QUESTS: " + str(GameData.data.player.completed_quests.size())

	var player = GameData.data.player
	$GuildOverview/PlayerName.text = player.name.to_upper()
	
	if player.experience < 100:
		$GuildOverview/PlayerExperience.text = "EXPERIENCE: APPRENTICE"
	elif player.experience < 300:
		$GuildOverview/PlayerExperience.text = "EXPERIENCE: NOVICE"
	elif player.experience < 1000:
		$GuildOverview/PlayerExperience.text = "EXPERIENCE: ADEPT"
	elif player.experience < 5000:
		$GuildOverview/PlayerExperience.text = "EXPERIENCE: ACCOMPLISHED"
	elif player.experience < 15000:
		$GuildOverview/PlayerExperience.text = "EXPERIENCE: EXPERT"
	elif player.experience < 50000:
		$GuildOverview/PlayerExperience.text = "EXPERIENCE: MASTER"
