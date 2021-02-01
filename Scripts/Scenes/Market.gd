extends Control

var equipment_slot = preload("res://Scenes/EquipmentSlot.tscn")
var equipment_popup = preload("res://Scenes/EquipmentPopup.tscn")
var banking = preload("res://Scripts/Utility/Bank.gd").new()
var popup
# Called when the node enters the scene tree for the first time.
func _ready():
	popup = equipment_popup.instance()
	popup.visible = false
	add_child(popup)

func init():
	_repopulate_containers()

func update_ui():
	pass

func _populate_shop_items():
	for equipment in GameData.data.equipment:
		var slot = equipment_slot.instance()
		slot.node_id = equipment.id
		slot.connect('mouse_entered', self, '_slot_hover', [slot, GameData.data.equipment])
		slot.connect('mouse_exited', self, '_slot_exit', [slot])
		slot.connect('button_up', self, '_slot_clicked', [slot])
		$MarketContainer/ALL/AllItemsContainer/AllItemsGrid.add_child(slot)

func _populate_guild_items():
	for equipment in GameData.data.player.guild.equipment:
		var slot = equipment_slot.instance()
		slot.node_id = equipment.id
		slot.connect('mouse_entered', self, '_slot_hover', [slot, GameData.data.player.guild.equipment])
		slot.connect('mouse_exited', self, '_slot_exit', [slot])
		slot.connect('button_up', self, '_slot_clicked', [slot])
		$EquipmentContainer/ALL/AllItemsContainer/AllItemsGrid.add_child(slot)

func _slot_hover(slot, items):
	slot.active = true
	popup.visible = true
	for item in items:
		if item.id == slot.node_id:
			popup.set_name(item.name.to_upper())
			popup.set_type(item.type.to_upper())
			popup.set_cost(str(item.cost))
			var slot_pos = slot.get_global_position()
			slot_pos.x = slot_pos.x + 50
			popup.set_position(slot_pos)

func _slot_exit(slot):
	slot.active = false
	popup.set_name("")
	popup.visible = false

func _slot_clicked(slot):
	var idx = 0
	for item in GameData.data.equipment:
		if item.id == slot.node_id:
			if banking.balance() >= item.cost:
				GameData.data.player.guild.equipment.push_back(item)
				banking.purchase(item.cost)
				GameData.data.equipment.remove(idx)
				_repopulate_containers()
			else:
				print('NOT ENOUGH MONEY!!')
	idx += 1

func _repopulate_containers():
	for child in $EquipmentContainer/ALL/AllItemsContainer/AllItemsGrid.get_children():
		$EquipmentContainer/ALL/AllItemsContainer/AllItemsGrid.remove_child(child)
	
	for child in $MarketContainer/ALL/AllItemsContainer/AllItemsGrid.get_children():
		$MarketContainer/ALL/AllItemsContainer/AllItemsGrid.remove_child(child)
	
	_populate_shop_items()
	_populate_guild_items()
