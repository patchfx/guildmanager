extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_name(name):
	$Name.text = name

func set_type(type):
	$Type.text = type

func set_cost(cost):
	$Cost.text = cost + "gp"
