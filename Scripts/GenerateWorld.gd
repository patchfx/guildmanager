extends Node

var dice = preload("res://Scripts/Dice.gd").new()
var uuid = preload("res://Scripts/UUID.gd").new()
var name_generator = preload("res://Scripts/NameGenerator.gd").new()

var npcs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func generate():
	randomize()
	load_quests()
	var years_with_population = 25
	var npcs_to_generate = 200

	for x in range(0, 25):
		generate_npcs(npcs_to_generate)
		generate_history()
		GameData.data.year += 1
		
	for x in range(0, 18):
		generate_history()
		GameData.data.year += 1
	
	npcs.shuffle()
	
	for npc in npcs:
		GameData.data.npcs[npc.id] = npc

func load_quests():
	for quest in GameData.data.quests:
		quest.id = uuid.v4()

func generate_npcs(initial_population):
	var populated_list = name_generator.load()
	
	for x in range(0,initial_population):
		var first_name = populated_list[randi()%(populated_list.size() - 1) + 1]
		var last_name = populated_list[randi()%(populated_list.size() - 1) + 1]
		var id = uuid.v4()
		var character = {
			"id": id,
			"name": first_name + " " + last_name,
			"might": dice.roll_multiple(3,6),
			"reflex": dice.roll_multiple(3,6),
			"mind": dice.roll_multiple(3,6),
			"constitution": dice.roll_multiple(3,6),
			"charisma": dice.roll_multiple(3,6),
			"xp": 0,
			"level": dice.roll_multiple(1, 10),
			"history": ["Born in the year " + str(GameData.data.year)]
		}
		npcs.push_back(character)

func generate_history():
	pass
