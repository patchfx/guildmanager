extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var characters = GameState.load();
	
	for character in characters:
		print(character)
