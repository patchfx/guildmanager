extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Party_button_up():
	if self.text == "CREATE NEW PARTY":
		get_parent().get_parent().get_parent().get_parent().get_parent().open_scene("CreateParty")
