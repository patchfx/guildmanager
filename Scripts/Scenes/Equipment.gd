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
		slot.node_id = equipment.id
		slot.connect('mouse_entered', self, '_slot_hover', [slot])
		slot.connect('mouse_exited', self, '_slot_exit', [slot])
		$GuildEquipmentGrid.add_child(slot)

func update_ui():
	pass

func _slot_hover(slot):
	slot.active = true
	print("ACTIVE " + slot.node_id)

func _slot_exit(slot):
	slot.active = false
	print("INACTIVE" + slot.node_id)


