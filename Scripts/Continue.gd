extends Control


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
				$QuestReward.text = "REWARD: " + str(quest.reward)

func update_ui():
	pass

func activate():
	pass
