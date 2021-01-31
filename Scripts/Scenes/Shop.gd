extends Control

var all_items = {}
var guild_items = {}
var filtered_all_items = {}
var filtered_guild_items = {}
var shop_selected = 0
var player_selected = 0
var player_tab = 0
var shop_tab = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	$PlayerInventoryList.clear()
	$ShopInventoryList.clear()
	var shop_inventory = $ShopInventoryList
	var guild_inventory = $PlayerInventoryList
	all_items = {}
	guild_items = {}
	filtered_all_items = {}
	filtered_guild_items = {}
	shop_selected = 0
	player_selected = 0
	player_tab = 0
	shop_tab = 0

	for item in GameData.data.equipment:
		if !all_items.keys().has(item.name):
			all_items[item.name] = []
			_add_item(shop_inventory, item.name)
		all_items[item.name].push_back(item)

	filtered_all_items = all_items
	
	for item in GameData.data.player.guild.equipment:
		if !guild_items.keys().has(item.name):
			guild_items[item.name] = []
			_add_item(guild_inventory, item.name)
		guild_items[item.name].push_back(item)
	
	filtered_guild_items = guild_items
	
	#_on_ShopInventoryList_item_selected(0)
	

func update_ui():
	pass

func _add_item(node, item):
	node.add_item(item.to_upper())


func _filter_list(node, type, items):
	var filtered = {}
	node.clear()

	for item in items.keys():
		var check_item = items[item]
		if check_item.size() > 0:
			if check_item[0].type == type || type == "all":
				_add_item(node, item)
				if !filtered.keys().has(item):
					filtered[item] = []
				filtered[item] = items[item]
	print(filtered)
	return filtered


func _on_ShopInventory_tab_changed(tab):
	var node = $ShopInventoryList
	shop_tab = tab
	if tab == 0:
		filtered_all_items = _filter_list(node, "all", all_items)
	elif tab == 1:
		filtered_all_items = _filter_list(node, "weapon", all_items)
	elif tab == 2:
		filtered_all_items = _filter_list(node, "armor", all_items)


func _on_PlayerInventory_tab_changed(tab):
	var node = $PlayerInventoryList
	player_tab = tab
	if tab == 0:
		filtered_guild_items = _filter_list(node, "all", guild_items)
	elif tab == 1:
		filtered_guild_items = _filter_list(node, "weapon", guild_items)
	elif tab == 2:
		filtered_guild_items = _filter_list(node, "armor", guild_items)


func _on_ShopInventoryList_item_selected(index):
	shop_selected = index
	var key = filtered_all_items.keys()[index]
	var item = filtered_all_items[key][0]
	$ItemName.visible = true
	$ItemName.text = item.name.to_upper()
	$BuyButton.text = "BUY " + str(item.cost) + "g"
	if GameData.data.player.gold >= item.cost:
		$BuyButton.disabled = false
	else:
		$BuyButton.disabled = true
	
	$BuyButton.visible = true
	$SellButton.visible = false


func _on_PlayerInventoryList_item_selected(index):
	player_selected = index
	var key = filtered_guild_items.keys()[index]
	var item = filtered_guild_items[key][0]
	$ItemName.visible = true
	$ItemName.text = item.name.to_upper()
	$SellButton.text = "SELL " + str(item.cost) + "g"
	$BuyButton.visible = false
	$SellButton.visible = true

func _on_BuyButton_button_up():
	var key = filtered_all_items.keys()[shop_selected]
	var item = filtered_all_items[key][0]
	var idx = 0
	for equipment in all_items[key]:
		if item.id == equipment.id:
			all_items[key].remove(idx)
			if !guild_items.keys().has(item.name):
				guild_items[item.name] = []
			guild_items[item.name].push_back(item)
			GameData.data.player.gold -= item.cost
			GameData.data.player.expenditure += item.cost
			var depreciation = (item.cost / 100) * 20
			if depreciation <= 0:
				depreciation = 1
			item.cost = item.cost - int(depreciation)
			GameData.data.player.guild.equipment.push_back(item)
		idx += 1

	_on_ShopInventory_tab_changed(shop_tab)
	_on_PlayerInventory_tab_changed(player_tab)
	_clear_item_panel()

func _on_SellButton_button_up():	
	var key = filtered_guild_items.keys()[player_selected]
	var item = filtered_guild_items[key][0]
	var idx = 0
	for equipment in guild_items[key]:
		if item.id == equipment.id:
			guild_items[key].remove(idx)
			GameData.data.player.gold += item.cost
			GameData.data.player.income += item.cost
		idx += 1
	
	idx = 0
	for equipment in GameData.data.player.guild.equipment:
		if item.id == equipment.id:
			GameData.data.player.guild.equipment.remove(idx)
		idx += 1

	_on_PlayerInventory_tab_changed(player_tab)
	_clear_item_panel()

func _clear_item_panel():
	$ItemName.visible = false
	$SellButton.visible = false
	$BuyButton.visible = false
