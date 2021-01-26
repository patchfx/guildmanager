extends MenuButton

var save_load = preload("res://Scripts/Utility/SaveLoad.gd").new()
var popup

func _ready():
	popup = get_popup()
	popup.add_item("SAVE GAME")
	popup.add_item("LOAD GAME")
	popup.add_item("QUIT")
	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(ID):
	var menu_pressed = popup.get_item_text(ID)
	if menu_pressed == "QUIT":
		get_parent().get_parent().get_tree().quit()
	elif menu_pressed == "SAVE GAME":
		save_load.save_game()
	elif menu_pressed == "LOAD GAME":
		save_load.load_save_file()
		get_parent().get_parent().open_scene("Dashboard")
