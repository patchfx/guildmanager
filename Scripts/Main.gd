extends Node

var world_generator = preload("res://Scripts/GenerateWorld.gd").new()
var loaded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print("Loading into memory")
	world_generator.generate()
	
	#var file = File.new()
	#file.open("res://Resources/generated.json", file.READ)
	#var json = file.get_as_text()
	#var json_result = JSON.parse(json)
	#file.close()
	
	print("Load done")

	#GameState.load(populated_list, "Falakin Pendrane")
	#var characters = GameState.npcs()

	#for character in characters:
		#print(character)
		
	var quests = GameData.data.quests

	for q in quests:
		var popup = load("res://Scenes/QuestPopup.tscn").instance()
		popup.init(q)
		add_child(popup)
	
	var player = GameData.data.player
	$Dashboard/GuildOverview/PlayerName.text = player.name.to_upper()
	
	if player.experience < 100:
		$Dashboard/GuildOverview/PlayerExperience.text = "EXPERIENCE: APPRENTICE"
	elif player.experience < 300:
		$Dashboard/GuildOverview/PlayerExperience.text = "EXPERIENCE: NOVICE"
	elif player.experience < 1000:
		$Dashboard/GuildOverview/PlayerExperience.text = "EXPERIENCE: ADEPT"
	elif player.experience < 5000:
		$Dashboard/GuildOverview/PlayerExperience.text = "EXPERIENCE: ACCOMPLISHED"
	elif player.experience < 15000:
		$Dashboard/GuildOverview/PlayerExperience.text = "EXPERIENCE: EXPERT"
	elif player.experience < 50000:
		$Dashboard/GuildOverview/PlayerExperience.text = "EXPERIENCE: MASTER"
	
	$TopBar/Gold.text = "GOLD: " + str(player.gold)
	loaded = true

func _process(delta):
	if loaded:
		var q = GameData.data.player.accepted_quests
		$TopBar/Quests.text = "Quests: " + str(q.size())
		$TopBar/Date.text = "Week " + str(GameData.data.week)
		
		var guild = GameData.data.player.guild
		$Dashboard/GuildOverview/GuildName.text = guild.name.to_upper()
		
		if guild.renown <= 1:
			$Dashboard/GuildOverview/GuildRenown.text = "RENOWN: UNKNOWN"
		elif guild.renown <= 5:
			$Dashboard/GuildOverview/GuildRenown.text = "RENOWN: KNOWN"
		elif guild.renown <= 10:
			$Dashboard/GuildOverview/GuildRenown.text = "RENOWN: RESPECTED"
		elif guild.renown <= 15:
			$Dashboard/GuildOverview/GuildRenown.text = "RENOWN: REVERED"

		$Dashboard/GuildOverview/CompletedQuests.text = "COMPLETED QUESTS: " + str(GameData.data.player.completed_quests.size())

func open_scene(scene_name):
	$Dashboard.visible = false
	get_node(scene_name).visible = true
