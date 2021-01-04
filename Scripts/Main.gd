extends Node

var name_generator = preload("res://Scripts/NameGenerator.gd").new()
var loaded = false

# Called when the node enters the scene tree for the first time.
func _ready():

	var populated_list = name_generator.load()

	GameState.load(populated_list)
	var characters = GameState.npcs()

	#for character in characters:
		#print(character)
		
	var quests = GameState.load_quests()

	for q in quests:
		var popup = load("res://Scenes/QuestPopup.tscn").instance()
		popup.init(q)
		add_child(popup)
	
	loaded = true

func _process(delta):
	if loaded:
		var q = GameState.current_quests()
		$TopBar/Quests.text = "Quests: " + str(q.size())
