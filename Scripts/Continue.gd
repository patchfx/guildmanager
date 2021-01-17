extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	pass

func update_ui():
	pass

func activate():
	if GameData.data.player.accepted_quests.size() > 0:
		$Label.text = "You have quests to complete!"
