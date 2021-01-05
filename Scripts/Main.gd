extends Node

var name_generator = preload("res://Scripts/NameGenerator.gd").new()
var loaded = false

# Called when the node enters the scene tree for the first time.
func _ready():

	var populated_list = name_generator.load()

	GameState.load(populated_list, "Falakin Pendrane")
	var characters = GameState.npcs()

	#for character in characters:
		#print(character)
		
	var quests = GameState.load_quests()

	for q in quests:
		var popup = load("res://Scenes/QuestPopup.tscn").instance()
		popup.init(q)
		add_child(popup)
	
	var player = GameState.player()
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
		var q = GameState.current_quests()
		$TopBar/Quests.text = "Quests: " + str(q.size())
		
		var week = GameState.week()
		$TopBar/Date.text = "Week " + str(week)
		

