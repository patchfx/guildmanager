extends Control

var party_members = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	party_members = []
	$PartyMembers.clear()
	$GuildMembers.clear()
	
	for id in GameData.data.player.guild.recruits:
		var recruit = GameData.data.npcs[id]
		$GuildMembers.add_item(recruit.name)
		party_members.push_back(id)

func update_ui():
	pass


func _on_GuildMembers_item_selected(index):
	var id = party_members[index]
	var recruit = GameData.data.npcs[id]
	$NameLabel.text = recruit.name.to_upper()
	$Might.text = str(recruit.might)
	$Mind.text = str(recruit.mind)
	$Constitution.text = str(recruit.constitution)
	$Charisma.text = str(recruit.charisma)
	$Reflex.text = str(recruit.reflex)
	$Level.text = str(recruit.level)
