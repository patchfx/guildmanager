extends Control

var party_members = []
var guild_members = []
var selected_party_member = 0

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
		guild_members.push_back(id)

	$PartyMembers.select(selected_party_member)

func update_ui():
	pass


func _on_GuildMembers_item_selected(index):
	selected_party_member = index
	var id = guild_members[index]
	var recruit = GameData.data.npcs[id]
	$NameLabel.text = recruit.name.to_upper()
	$Might.text = str(recruit.might)
	$Mind.text = str(recruit.mind)
	$Constitution.text = str(recruit.constitution)
	$Charisma.text = str(recruit.charisma)
	$Reflex.text = str(recruit.reflex)
	$Level.text = str(recruit.level)


func _on_CreateNewParty_button_up():
	print("CREATE NEW PARTY " + $PartyName.text)


func _on_PartyName_text_changed(new_text):
	if new_text.length() > 0 and $PartyMembers.get_item_count() > 0:
		$CreateNewParty.disabled = false
	else:
		$CreateNewParty.disabled = true


func _on_AddMember_button_up():
	var id = GameData.data.player.guild.recruits[selected_party_member]
	for npc_id in GameData.data.npcs:
		if id == npc_id:
			var recruit = GameData.data.npcs[id]
			$PartyMembers.add_item(recruit.name)
			$GuildMembers.remove_item(selected_party_member)
