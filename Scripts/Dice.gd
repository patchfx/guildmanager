extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func roll_multiple(rolls, sides):
	var total = 0
	
	for x in range(0, rolls):
		total += randi()%sides+1
	
	return(total)
