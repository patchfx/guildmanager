extends Control

var equipment_slot = preload("res://Scenes/EquipmentSlot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	for equipment in GameData.data.equipment:
		var slot = equipment_slot.instance()
		slot.node_id = equipment.id
		slot.connect('mouse_entered', self, '_slot_hover', [slot])
		slot.connect('mouse_exited', self, '_slot_exit', [slot])
		$MarketContainer/ALL/AllItemsContainer/AllItemsGrid.add_child(slot)

func update_ui():
	pass

func _slot_hover(slot):
	slot.active = true
	$EquipmentPopup.visible = true
	for item in GameData.data.equipment:
		if item.id == slot.node_id:
			$EquipmentPopup/Name.text = item.name.to_upper()
			
			var slot_pos = slot.get_position()
			slot_pos.x = slot_pos.x + 50
			$EquipmentPopup.set_position(slot_pos)

func _slot_exit(slot):
	slot.active = false
	$EquipmentPopup/Name.text = ""
	$EquipmentPopup.visible = false
