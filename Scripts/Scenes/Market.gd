extends Control

var equipment_slot = preload("res://Scenes/EquipmentSlot.tscn")
var equipment_popup = preload("res://Scenes/EquipmentPopup.tscn")

var popup
# Called when the node enters the scene tree for the first time.
func _ready():
	popup = equipment_popup.instance()
	popup.visible = false
	add_child(popup)

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
	popup.visible = true
	for item in GameData.data.equipment:
		if item.id == slot.node_id:
			popup.get_node("Name").text = item.name.to_upper()
			
			var slot_pos = slot.get_position()
			slot_pos.x = slot_pos.x + 50
			popup.set_position(slot_pos)

func _slot_exit(slot):
	slot.active = false
	popup.get_node("Name").text = ""
	popup.visible = false
