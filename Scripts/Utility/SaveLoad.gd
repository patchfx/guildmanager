extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func save_game():
	var file = File.new()
	var location = "user://save_game.sav"

	print("Saving game to: " + OS.get_user_data_dir())
	if file.open(location, File.WRITE) != 0:
		print("Cannot write save file to " + location)
	else:
		file.store_line(to_json(GameData.data))
		file.close()

func load_save_file():
	var file = File.new()
	file.open("user://save_game.sav", file.READ)
	var text = file.get_as_text()
	GameData.data = parse_json(text)
	file.close()
