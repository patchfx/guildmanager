extends Node

var dice = preload("res://Scripts/Dice.gd").new()
var uuid = preload("res://Scripts/UUID.gd").new()
var name_generator = preload("res://Scripts/NameGenerator.gd").new()

var npcs = []
enum Motivator {
	ACHIEVEMENT,
	ACQUISITION,
	ADORATION,
	PEACE,
	BENEFICENCE,
	CHAOS,
	COMPETITION,
	CONFLICT,
	CONQUEST,
	CORRUPTION,
	CREATION,
	DESTRUCTION,
	DISCOVERY,
	DOMESTICITY,
	EDUCATION,
	ENTERTAINMENT,
	ENSLAVEMENT,
	HEDONISM,
	HEROISM,
	HONOR,
	LIBERATION,
	LOVE,
	ORDER,
	PLAY,
	POWER,
	PROSELYTIZATION,
	PURITY,
	REBELLION,
	RECOGNITION,
	SERVICE,
	TORMENT,
	UNDERSTANDING,
	VICE
}

enum Disposition {
	JOYFUL,
	ANXIOUS,
	ANGRY,
	CONTEMPTUOUS,
	EXCITED,
	CURIOUS,
	APATHETIC,
	CALM,
	ASHAMED
}

enum Outlook {
	OPTMISTIC,
	PESSIMISTIC
}

enum Integrity {
	Conscientious,
	Unscrupulous
}

enum Impulsiveness {
	Controlled,
	Spontaneous
}

enum Boldness {
	Intrepid,
	Cautious
}

enum Agreeableness {
	Agreeable,
	Disagreeable
}

enum Interactivity {
	Engaging,
	Reserved
}

enum Conformity {
	Conventional,
	Heterodox
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
	var motivators = Motivator.keys()
	var disposition = Disposition.keys()
	var impulsiveness = Impulsiveness.keys()
	var boldness = Boldness.keys()
	var outlook = Outlook.keys()
	var integrity = Integrity.keys()
	var interactivity = Interactivity.keys()
	var conformity = Conformity.keys()
	
	for _x in range(0,initial_population):
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
			"traits": {},
			"recruitable": true,
			"history": ["Born in the year " + str(GameData.data.year)]
		}
		
		character.traits["motivator"] = motivators[randi()%(motivators.size()) - 1]
		character.traits["disposition"] = disposition[randi()%(disposition.size() - 1) - 1]
		character.traits["outlook"] = outlook[randi()%(outlook.size()) - 1]
		character.traits["impulsiveness"] = impulsiveness[randi()%(impulsiveness.size()) - 1]
		character.traits["boldness"] = boldness[randi()%(boldness.size()) - 1]
		character.traits["integrity"] = integrity[randi()%(integrity.size()) - 1]
		character.traits["interactivity"] = interactivity[randi()%(interactivity.size()) - 1]
		character.traits["conformity"] = conformity[randi()%(conformity.size()) - 1]
	
		npcs.push_back(character)

func add_faction_leaders():

	for faction in GameData.data.factions:
		var leader = npcs[randi()%(npcs.size() - 1)]
		leader.recruitable = false
		leader.history.push_back("Appointed leader of the " + faction.name + " faction")
		faction.leader = leader.id

func generate_years_history():
	pass
