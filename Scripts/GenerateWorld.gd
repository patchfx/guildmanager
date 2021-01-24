extends Node

var dice = preload("res://Scripts/Dice.gd").new()
var uuid = preload("res://Scripts/UUID.gd").new()
var name_generator = preload("res://Scripts/NameGenerator.gd").new()
var personality_traits = preload("res://Scripts/PersonalityTraits.gd").new()

var npcs = []

func generate():
	randomize()
	load_quests()
	var years_with_population = 25
	var npcs_to_generate = 200

	for _x in range(0, years_with_population):
		generate_npcs(npcs_to_generate)
		generate_years_history()
		GameData.data.year += 1
	
	add_faction_leaders()
		
	for _x in range(0, 18):
		generate_npcs(npcs_to_generate)
		generate_years_history()
		GameData.data.year += 1

	npcs.shuffle()
	
	for npc in npcs:
		GameData.data.npcs[npc.id] = npc


func load_quests():
	for quest in GameData.data.quests:
		quest.id = uuid.v4()

func generate_npcs(initial_population):
	var populated_list = name_generator.load()

	for _x in range(0,initial_population):
		var first_name = populated_list[randi()%(populated_list.size() - 1) + 1]
		var last_name = populated_list[randi()%(populated_list.size() - 1) + 1]
		var id = uuid.v4()
		var character = {
			"id": id,
			"age": 0,
			"name": first_name + " " + last_name,
			"might": dice.roll_multiple(3,6),
			"reflex": dice.roll_multiple(3,6),
			"mind": dice.roll_multiple(3,6),
			"constitution": dice.roll_multiple(3,6),
			"charisma": dice.roll_multiple(3,6),
			"xp": 0,
			"level": dice.roll_multiple(1, 10),
			"traits": {},
			"recruitable": true,
			"faction": "",
			"history": ["Born in the year " + str(GameData.data.year)]
		}
		
		personality_traits.add_personality_traits_to(character)
		
		npcs.push_back(character)
		
	for _i in range(100):
		var id = uuid.v4()
		var first_name = populated_list[randi()%(populated_list.size() - 1) + 1]
		var last_name = populated_list[randi()%(populated_list.size() - 1) + 1]
		var kobold = {
			"id": id,
			"age": 0,
			"name": first_name + " " + last_name,
			"might": 7,
			"reflex": 15,
			"constitution": 9,
			"mind": 8,
			"charisma": 8,
			"xp": 0,
			"level": 1,
			"traits": {},
			"recruitable": false,
			"faction": "Kobolds",
			"history": ["Born in the year " + str(GameData.data.year)]
		}
		npcs.push_back(kobold)
	
func add_faction_leaders():
	for faction in GameData.data.factions:
		faction.id = uuid.v4()
		var leader = npcs[randi()%(npcs.size() - 1)]
		if leader.recruitable == true:
			leader.recruitable = false
			leader.faction = faction.id
			leader.history.push_back("Appointed leader of the " + faction.name + " faction")
			faction.leader = leader.id

func add_npcs_to_factions():
	for npc in npcs:
		if npc.recruitable and npc.faction.empty() and npc.age == 18:
			var faction = GameData.data.factions[randi()%(GameData.data.factions.size() - 1)]
			npc.faction = faction.id
			npc.history.push_back("Sworn into the service of " + faction.name)
			
func generate_years_history():
	add_npcs_to_factions()
	for npc in npcs:
		npc.age += 1
