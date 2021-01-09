extends Node

var data = {
	"week": 1,
	"year": 768,
	"player": {
		"name": "Falakin Pendrane",
		"gold": 10,
		"experience": 0,
		"accepted_quests": [],
		"completed_quests": [],
		"guild": {
			"name": "The Hammerthorns",
			"renown": 1,
			"recruits": []
		}
	},
	"quests": [{
		"id": 0,
		"name": "Kill 4 Kobolds",
		"description": "I am Quinn Goraneth, mayor of Fellspeare Village. A band of [color=#ff0000]4 Kobolds[/color] attacked during the night stealing from our already dwindling supplies. We have little coin, hence why we are approaching your fledgling guild, but we will pay what we can spare as a reward. Can you help?",
		"reward": 10,
		"quest_type": "Generic",
		"conditions": { "kill": 4, "enemy": "kobold" }
	}],
	"locations": [
		{ "id": 0, "name": "Blackspell", "max_population": 30 }
	],
	"npcs": []
}
