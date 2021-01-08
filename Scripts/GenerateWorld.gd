extends Node

var dice = preload("res://Scripts/Dice.gd").new()
var uuid = preload("res://Scripts/UUID.gd").new()
var name_generator = preload("res://Scripts/NameGenerator.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generate():
	load_quests()
	generate_npcs(5000)

func load_quests():
	for quest in GameData.data.quests:
		quest.id = uuid.v4()

func generate_npcs(initial_population):
	var populated_list = name_generator.load()
	
	for x in range(0,initial_population):
		var first_name = populated_list[randi()%(populated_list.size() - 1) + 1]
		var last_name = populated_list[randi()%(populated_list.size() - 1) + 1]
		var character = {
			"id": uuid.v4(),
			"name": first_name + " " + last_name,
			"might": dice.roll_multiple(3,6),
			"reflex": dice.roll_multiple(3,6),
			"mind": dice.roll_multiple(3,6),
			"constitution": dice.roll_multiple(3,6),
			"charisma": dice.roll_multiple(3,6),
			"xp": 0,
			"level": dice.roll_multiple(1, 10)
		}
		GameData.data.npcs.push_back(character)
		#print(character)
