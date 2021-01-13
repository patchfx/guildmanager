extends MenuButton

var popup

func _ready():
	popup = get_popup()
	popup.add_item("SAVE GAME")
	popup.add_item("QUIT")
	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(ID):
	var menu_pressed = popup.get_item_text(ID)
	if menu_pressed == "QUIT":
		get_parent().get_parent().get_tree().quit()
	elif menu_pressed == "SAVE GAME":
		print("SAVE THE GAME!")
	print(popup.get_item_text(ID), " pressed")
