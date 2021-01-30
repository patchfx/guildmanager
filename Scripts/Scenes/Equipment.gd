extends Control

var equipment_slot = preload("res://Scenes/EquipmentSlot.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init():
	for equipment in GameData.data.player.guild.equipment:
		var slot = equipment_slot.instance()
		$GuildEquipmentContainer/GuildEquipmentGrid.add_child(slot)

func update_ui():
	pass
