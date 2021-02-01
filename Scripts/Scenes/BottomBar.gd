extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_HireButton_button_up():
	get_parent().open_scene("Hire")

func _on_ContinueButton_button_up():
	if get_parent().active_scene == "Continue":
		get_parent().get_node("Continue").next()
	else:
		get_parent().open_scene("Continue")
		get_parent().get_node("Continue").activate()

func _on_DashboardButton_button_up():
	get_parent().open_scene("Dashboard")

func _on_ShopButton_button_up():
	get_parent().open_scene("Market")
