extends Node

var game = {
	"version": "0.1"
}

var data = {
	"week": 1,
	"year": 738,
	"player": {
		"name": "Falakin Pendrane",
		"gold": 50,
		"income": 0,
		"expenditure": 0,
		"experience": 0,
		"accepted_quests": [],
		"active_quests": [],
		"completed_quests": [],
		"guild": {
			"name": "The Hammerthorns",
			"renown": 1,
			"recruits": [],
			"parties": [],
			"equipment": [
				{ "id": "303020202929", "name": "short sword", "type": "weapon", "cost": 3 },
				{ "id": "292918182881", "name": "kite shield", "type": "armor", "cost": 5 }
			]
		}
	},
	"quests": [{
		"id": 0,
		"name": "Kill 2 Kobolds",
		"description": "I am Quinn Goraneth, mayor of Fellspeare Village. A band of [color=#ff0000]4 Kobolds[/color] attacked during the night stealing from our already dwindling supplies. We have little coin, hence why we are approaching your fledgling guild, but we will pay what we can spare as a reward. Can you help?",
		"reward": 10,
		"quest_type": "Generic",
		"conditions": { "kill": 2, "faction": "Kobolds" },
		"enemies": [],
		"parties": []
	}],
	"locations": [
		{ "id": 0, "name": "Blackspell", "max_population": 30 }
	],
	"equipment": [
		{ "id": "92928127171718", "name": "sword", "type": "weapon", "cost": 3 },
		{ "id": "81281817217718", "name": "shield", "type": "armor", "cost": 5 }
	],
	"npcs": {},
	"factions": [
		{
			"id": "",
			"name": "Paviland",
			"locations": [],
			"leader": ""
		},
		{
			"id": "",
			"name": "Gael Riata",
			"locations": [],
			"leader": ""
		},
		{
			"id": "",
			"name": "Aenglia",
			"locations": [],
			"leader": ""
		},
		{
			"id": "",
			"name": "Lyssandra",
			"locations": [],
			"leader": ""
		},
		{
			"id": "",
			"name": "Pendryll",
			"locations": [],
			"leader": ""
		},
		{
			"id": "",
			"name": "Caerdwn",
			"locations": [],
			"leader": ""
		},
	]
}
