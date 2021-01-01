extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.load();
	var characters = GameState.npcs()
	
	for character in characters:
		print(character)
