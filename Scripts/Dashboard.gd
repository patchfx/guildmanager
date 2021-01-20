extends Control

var party_grid_item = preload("res://Scenes/PartyGridItem.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func init():
	var item = party_grid_item.instance()
	item.text = "CREATE NEW PARTY"
	if GameData.data.player.guild.recruits.size() == 0:
		item.disabled = true
	else:
		item.disabled = false
	var party_grid = get_node("Parties/PartyScrollContainer/PartyGrid")
	for party_item in party_grid.get_children():
		party_grid.remove_child(party_item)
	party_grid.add_child(item)
	
	for party in GameData.data.player.guild.parties:
		var party_item = party_grid_item.instance()
		party_item.text = party.name
		party_grid.add_child(party_item)

func update_ui():
	var guild = GameData.data.player.guild
	$GuildOverview/GuildName.text = guild.name.to_upper()
	$GuildOverview/GoldTotal.text = "GOLD: " + str(GameData.data.player.gold) + "g"
	$GuildOverview/ExpensesTotal.text = "EXPENSES: " + str(GameData.data.player.expenditure) + "g"
	$GuildOverview/WeeklyGain.text = "EARNINGS: " + str(GameData.data.player.income) + "g"
	
	var change = GameData.data.player.income - GameData.data.player.expenditure
	if change < 0:
		$GuildOverview/WeeklyChange.bbcode_text = "CHANGE: [color=#ff0000]" + str(change) + "g[/color]"
	elif change == 0:
		$GuildOverview/WeeklyChange.text = "CHANGE: " + str(change) + "g"
	else:
		$GuildOverview/WeeklyChange.text = "CHANGE: [color=#00ff00]+" + str(change) + "g[/color]"
		
	
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
	
	$GuildOverview/RecruitsCount.text = "RECRUITS: " + str(GameData.data.player.guild.recruits.size())
