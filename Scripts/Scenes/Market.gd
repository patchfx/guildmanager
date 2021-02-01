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
		var filtered_slot = equipment_slot.instance()
		slot.node_id = equipment.id
		filtered_slot.node_id = equipment.id
		slot.connect('mouse_entered', self, '_slot_hover', [slot, GameData.data.equipment])
		slot.connect('mouse_exited', self, '_slot_exit', [slot])
		slot.connect('button_up', self, '_slot_purchase', [slot])
		
		filtered_slot.connect('mouse_entered', self, '_slot_hover', [filtered_slot, GameData.data.equipment])
		filtered_slot.connect('mouse_exited', self, '_slot_exit', [filtered_slot])
		filtered_slot.connect('button_up', self, '_slot_purchase', [filtered_slot])
		
		if equipment.type == "weapon":
			$MarketContainer/WEAPONS/WeaponsItemsContainer/WeaponsItemsGrid.add_child(filtered_slot)
		elif equipment.type == "armor":
			$MarketContainer/ARMOR/ArmorItemsContainer/ArmorItemsGrid.add_child(filtered_slot)
		$MarketContainer/ALL/AllItemsContainer/AllItemsGrid.add_child(slot)

func _populate_guild_items():
	for equipment in GameData.data.player.guild.equipment:
		var slot = equipment_slot.instance()
		var filtered_slot = equipment_slot.instance()
		slot.node_id = equipment.id
		filtered_slot.node_id = equipment.id
		
		slot.connect('mouse_entered', self, '_slot_hover', [slot, GameData.data.player.guild.equipment])
		slot.connect('mouse_exited', self, '_slot_exit', [slot])
		slot.connect('button_up', self, '_slot_sell', [slot])
		
		filtered_slot.connect('mouse_entered', self, '_slot_hover', [filtered_slot, GameData.data.player.guild.equipment])
		filtered_slot.connect('mouse_exited', self, '_slot_exit', [filtered_slot])
		filtered_slot.connect('button_up', self, '_slot_sell', [filtered_slot])
		if equipment.type == "weapon":
			$EquipmentContainer/WEAPONS/WeaponsItemsContainer/WeaponsItemsGrid.add_child(filtered_slot)
		elif equipment.type == "armor":
			$EquipmentContainer/ARMOR/ArmorItemsContainer/ArmorItemsGrid.add_child(filtered_slot)
	
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

func _slot_purchase(slot):
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

func _slot_sell(slot):
	var idx = 0
	for item in GameData.data.player.guild.equipment:
		if item.id == slot.node_id:
			GameData.data.player.guild.equipment.remove(idx)
			banking.sell(item.cost)
			print("SELLING " + item.name)
			_repopulate_containers()
	idx += 1

func _repopulate_containers():
	for child in $EquipmentContainer/ALL/AllItemsContainer/AllItemsGrid.get_children():
		$EquipmentContainer/ALL/AllItemsContainer/AllItemsGrid.remove_child(child)
	
	for child in $EquipmentContainer/ARMOR/ArmorItemsContainer/ArmorItemsGrid.get_children():
		$EquipmentContainer/ARMOR/ArmorItemsContainer/ArmorItemsGrid.remove_child(child)
		
	for child in $EquipmentContainer/WEAPONS/WeaponsItemsContainer/WeaponsItemsGrid.get_children():
		$EquipmentContainer/WEAPONS/WeaponsItemsContainer/WeaponsItemsGrid.remove_child(child)
	
	for child in $MarketContainer/ALL/AllItemsContainer/AllItemsGrid.get_children():
		$MarketContainer/ALL/AllItemsContainer/AllItemsGrid.remove_child(child)
	
	for child in $MarketContainer/ARMOR/ArmorItemsContainer/ArmorItemsGrid.get_children():
		$MarketContainer/ARMOR/ArmorItemsContainer/ArmorItemsGrid.remove_child(child)
		
	for child in $MarketContainer/WEAPONS/WeaponsItemsContainer/WeaponsItemsGrid.get_children():
		$MarketContainer/WEAPONS/WeaponsItemsContainer/WeaponsItemsGrid.remove_child(child)
	
	_populate_shop_items()
	_populate_guild_items()
