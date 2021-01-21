extends Control

var party_grid_item = preload("res://Scenes/PartyGridItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	if GameData.data.player.accepted_quests.size() > 0:
		var id = GameData.data.player.accepted_quests[0]
		
		for quest in GameData.data.quests:
			if quest.id == id:
				$QuestTitle.text = quest.name
				$QuestDescription.bbcode_text = quest.description
				$QuestDifficulty.text = "DIFFICULTY: EASY"
				$QuestReward.text = "REWARD: " + str(quest.reward) + "g"
	var party_grid = get_node("PartyScrollContainer/PartyGrid")
	for party_item in party_grid.get_children():
		party_grid.remove_child(party_item)

	for party in GameData.data.player.guild.parties:
		var party_item = party_grid_item.instance()
		party_item.connect("button_up", self, "party_clicked", [party.name])
		party_item.text = party.name
		party_grid.add_child(party_item)


func update_ui():
	pass

func activate():
	pass

func party_clicked(name):
	var party_grid = get_node("PartyScrollContainer/PartyGrid")
	var assigned_party_grid = get_node("AssignedePartyScrollContainer/AssignedPartyGrid")
	var party_item = party_grid_item.instance()
	party_item.text = name
	assigned_party_grid.add_child(party_item)
	
	for item in party_grid.get_children():
		if item.text == name:
			party_grid.remove_child(item)
		
