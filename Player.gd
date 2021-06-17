extends Node
var inventory: Array = []

func take_item(item: Item):
	inventory.append(item)
	
func drop_item(item: Item):
	inventory.erase(item)

func get_inventory_list() -> String:
	if inventory.size() == 0:
		return "No hay objetos en tu mochila"
		
	var inventory_string = ""
	for item in inventory:
		inventory_string += item.item_name + " "
		
	return "Mochila: " + inventory_string
