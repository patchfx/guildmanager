extends Node

var player = GameData.data.player


func purchase(cost):
	player.gold -= cost
	player.expenditure += cost

func balance():
	return player.gold
