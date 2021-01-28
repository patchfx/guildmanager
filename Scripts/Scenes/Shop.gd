extends Control

var all_items = []
var guild_items = []
var filtered_all_items = []
var filtered_guild_items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	var shop_inventory = $ShopInventoryList
	var guild_inventory = $PlayerInventoryList

	for item in GameData.data.equipment:
		all_items.push_back(item)
		_add_item(shop_inventory, item.name)
	filtered_all_items = all_items
	
	for item in GameData.data.player.guild.equipment:
		guild_items.push_back(item)
		_add_item(guild_inventory, item.name)
	filtered_guild_items = guild_items
	

func update_ui():
	pass

func _add_item(node, item):
	node.add_item(item.to_upper())


func _filter_list(node, type, items):
	var filtered = []
	node.clear()

	for item in items:
		if item.type == type || type == "all":
			_add_item(node, item.name)
			filtered.push_back(item)
	return filtered


func _on_ShopInventory_tab_changed(tab):
	var node = $ShopInventoryList

	if tab == 0:
		filtered_all_items = _filter_list(node, "all", all_items)
	elif tab == 1:
		filtered_all_items = _filter_list(node, "weapon", all_items)
	elif tab == 2:
		filtered_all_items = _filter_list(node, "armor", all_items)


func _on_PlayerInventory_tab_changed(tab):
	var node = $PlayerInventoryList
	if tab == 0:
		filtered_guild_items = _filter_list(node, "all", guild_items)
	elif tab == 1:
		filtered_guild_items = _filter_list(node, "weapon", guild_items)
	elif tab == 2:
		filtered_guild_items = _filter_list(node, "armor", guild_items)


func _on_ShopInventoryList_item_selected(index):
	var item = filtered_all_items[index]
	$ItemName.text = item.name.to_upper()


func _on_PlayerInventoryList_item_selected(index):
	var item = filtered_guild_items[index]
	$ItemName.text = item.name.to_upper()
