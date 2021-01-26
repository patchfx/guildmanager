extends Control

var all_items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	var sword = { "name": "sword", "type": "weapon", "cost": 3 }
	var shield = { "name": "shield", "type": "armor", "cost": 5 }

	all_items.push_back(sword)
	all_items.push_back(shield)

	for item in all_items:
		_add_item(item.name)


func _add_item(item):
	$InventoryList.add_item(item.to_upper())

func update_ui():
	pass


func _on_ShopInventory_tab_changed(tab):
	if tab == 0:
		_filter_list("all")
	elif tab == 1:
		_filter_list("weapon")
	elif tab == 2:
		_filter_list("armor")

func _filter_list(type):
	$InventoryList.clear()

	for item in all_items:
		if item.type == type || type == "all":
			_add_item(item.name)