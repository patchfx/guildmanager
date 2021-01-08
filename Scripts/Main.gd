extends Node

var world_generator = preload("res://Scripts/GenerateWorld.gd").new()
var loaded = false

var active_scene = "Dashboard"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print("Generating game world")
	world_generator.generate()
	
	#var file = File.new()
	#file.open("res://Resources/generated.json", file.READ)
	#var json = file.get_as_text()
	#var json_result = JSON.parse(json)
	#file.close()
	
	print("Generating done")

		
	var quests = GameData.data.quests

	for q in quests:
		var popup = load("res://Scenes/QuestPopup.tscn").instance()
		popup.init(q)
		add_child(popup)

	loaded = true

func _process(delta):
	if loaded:
		var q = GameData.data.player.accepted_quests
		$TopBar/Gold.text = "GOLD: " + str(GameData.data.player.gold)
		$TopBar/Quests.text = "Quests: " + str(q.size())
		$TopBar/Date.text = "Week " + str(GameData.data.week)
		get_node(active_scene).update_ui()

func open_scene(scene_name):
	$Dashboard.visible = false
	var target_node = get_node(scene_name)
	target_node.init()
	target_node.visible = true
