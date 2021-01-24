extends Control

var dice = preload("res://Scripts/Dice.gd").new()
var combat = preload("res://Scripts/Combat.gd").new()
var combat_order = []

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init():
	var quest = GameData.data.player.active_quests[0]
	$QuestName.text = quest.name
	for npc in quest.enemies:
		combat_order.push_front(npc)
	
	for party in quest.parties:
		for recruit_id in party.recruits:
			var recruit = GameData.data.npcs[recruit_id]
			var dice_roll = dice.roll_multiple(3, 6)
			if dice_roll > recruit.reflex:
				combat_order.push_back(recruit_id)
			else:
				combat_order.push_front(recruit_id)

	combat.init(combat_order)
	combat.play_round()


func update_ui():
	pass
