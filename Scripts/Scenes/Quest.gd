extends Control

var dice = preload("res://Scripts/Utility/Dice.gd").new()
var combat = preload("res://Scripts/Utility/Combat.gd").new()
var combat_order = []
var enemies = []
var friendlies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init():
	var quest = GameData.data.player.active_quests[0]
	$QuestName.text = quest.name
	for npc in quest.enemies:
		combat_order.push_front(npc)
		enemies.push_back(npc)
	
	for party in quest.parties:
		for recruit_id in party.recruits:
			var recruit = GameData.data.npcs[recruit_id]
			var dice_roll = dice.roll_multiple(3, 6)
			if dice_roll > recruit.reflex:
				combat_order.push_back(recruit_id)
			else:
				combat_order.push_front(recruit_id)
			friendlies.push_back(recruit_id)

	combat.init(combat_order, friendlies, enemies)
	combat.play_round()


func update_ui():
	pass


func _on_TakeTurn_button_up():
	combat.play_round()
