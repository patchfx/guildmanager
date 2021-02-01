extends Node

var player = GameData.data.player


func balance():
	return player.gold

func purchase(cost):
	player.gold -= cost
	player.expenditure += cost

func sell(cost):
	player.gold += cost
	player.income += cost
