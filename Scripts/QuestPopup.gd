extends TextureRect

var quest

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(q):
	quest = q
	$TitleText.text = quest.name
	$BodyText.bbcode_text = quest.description + "\n\n" + "Reward: [color=#dbcd00]" + str(quest.reward) + "g[/color]"

func _on_QuestButton_button_up():
	get_parent().remove_child(self)
	GameData.data.player.accepted_quests.push_back(quest.id)
