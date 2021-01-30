extends Control

var party_members = []
var guild_members = []
var selected_party_member = 0
var uuid = preload("res://Scripts/Utility/UUID.gd").new()

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
	$AddMember.visible = true
	$RemoveMember.visible = false
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

func _on_PartyMembers_item_selected(index):
	$AddMember.visible = false
	$RemoveMember.visible = true
	selected_party_member = index
	var id = party_members[index]
	var recruit = GameData.data.npcs[id]
	$NameLabel.text = recruit.name.to_upper()
	$Might.text = str(recruit.might)
	$Mind.text = str(recruit.mind)
	$Constitution.text = str(recruit.constitution)
	$Charisma.text = str(recruit.charisma)
	$Reflex.text = str(recruit.reflex)
	$Level.text = str(recruit.level)


func _on_CreateNewParty_button_up():
	var recruits = []
	var item_count = $PartyMembers.get_item_count()
	for idx in range(0, item_count):
		var recruit = $PartyMembers.get_item_text(idx)
		for npc_id in GameData.data.npcs:
			if GameData.data.npcs[npc_id].name == recruit:
				var npc = GameData.data.npcs[npc_id]
				recruits.push_back(npc.id)

	var party = {
		"id": uuid.v4(),
		"name": $PartyName.text,
		"recruits": recruits
	}
		
	GameData.data.player.guild.parties.push_back(party)
	
	get_parent().open_scene("Dashboard")


func _on_PartyName_text_changed(new_text):
	if new_text.length() > 0 and $PartyMembers.get_item_count() > 0:
		$CreateNewParty.disabled = false
	else:
		$CreateNewParty.disabled = true


func _on_AddMember_button_up():
	var id = guild_members[selected_party_member]
	for npc_id in GameData.data.npcs:
		if id == npc_id:
			var recruit = GameData.data.npcs[id]
			$PartyMembers.add_item(recruit.name)
			$GuildMembers.remove_item(selected_party_member)
			guild_members.erase(id)
			party_members.push_back(id)
	if $PartyName.text.length() > 0 and $PartyMembers.get_item_count() > 0:
		$CreateNewParty.disabled = false
	else:
		$CreateNewParty.disabled = true
		


func _on_RemoveMember_button_up():
	var id = party_members[selected_party_member]
	for npc_id in GameData.data.npcs:
		if id == npc_id:
			var recruit = GameData.data.npcs[id]
			$GuildMembers.add_item(recruit.name)
			$PartyMembers.remove_item(selected_party_member)
			party_members.erase(id)
			guild_members.push_back(id)
	if $PartyName.text.length() > 0 and $PartyMembers.get_item_count() > 0:
		$CreateNewParty.disabled = false
	else:
		$CreateNewParty.disabled = true
