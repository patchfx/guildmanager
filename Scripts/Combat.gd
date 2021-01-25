extends Node

var dice = preload("res://Scripts/Dice.gd").new()

var combatants = []
var friendlies = []
var enemies = []

# TODO: Calculate this from weapons table 
var hit_dice = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init(characters, friendly, enemy):
	combatants = characters
	friendlies = friendly
	enemies = enemy

func play_round():
	for id in combatants:
		var npc = GameData.data.npcs[id]
		var target = _find_target_for(id)
		var might_check = dice.roll_multiple(3,6) - 1
		if might_check <= npc.might:
			hit_dice = npc.equipped["right_hand"][0].hit_dice
			print("HIT DICE: " + str(hit_dice))
			var dmg = dice.roll_multiple(1,hit_dice)
			print(npc.name + " HITS " + GameData.data.npcs[target].name + " for " + str(dmg) + " dmg")
		else:
			print(npc.name + " MISSES " + GameData.data.npcs[target].name)

func _find_target_for(character):
		randomize()
		if friendlies.has(character):
			var idx:int = randi() % enemies.size()
			return enemies[idx]
		elif enemies.has(character):
			var idx:int = randi() % friendlies.size()
			return friendlies[idx]
