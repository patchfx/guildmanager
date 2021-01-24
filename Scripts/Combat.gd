extends Node

var dice = preload("res://Scripts/Dice.gd").new()

var combatants = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init(characters):
	combatants = characters

func play_round():
	for id in combatants:
		var npc = GameData.data.npcs[id]
		var might_check = dice.roll_multiple(3,6) - 1
		if might_check <= npc.might:
			print(npc.name + " HITS!")
		else:
			print(npc.name + " MISSES!")
