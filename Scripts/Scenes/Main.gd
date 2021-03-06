extends Node

var world_generator = preload("res://Scripts/Generators/GenerateWorld.gd").new()
var loaded = false

var active_scene = "Dashboard"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print("Generating game world")
	world_generator.generate()
	print("Generating done")

	var quests = GameData.data.quests

	for q in quests:
		var popup = load("res://Scenes/QuestPopup.tscn").instance()
		popup.init(q)
		add_child(popup)

	loaded = true
	open_scene(active_scene)

func _process(_delta):
	if loaded:

		get_node("TopBar").update_ui()
		get_node(active_scene).update_ui()

func open_scene(scene_name):
	$Dashboard.visible = false
	$Hire.visible = false
	$Continue.visible = false
	$CreateParty.visible = false
	$Quest.visible = false

	$Equipment.visible = false
	$Market.visible = false
	var target_node = get_node(scene_name)
	target_node.init()
	target_node.visible = true
	active_scene = scene_name
