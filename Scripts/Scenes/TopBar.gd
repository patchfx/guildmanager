extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_ui():
	$Date.text = "WEEK " + str(GameData.data.week) + " IN THE YEAR " + str(GameData.data.year)
