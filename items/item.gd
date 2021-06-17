extends Resource
class_name Item

export (String) var item_name := "Item Name"
export (Types.ItemTypes) var item_type := Types.ItemTypes.KEY

var use_value = null

func initialize(name: String, type: int):
	self.item_name = name
	self.item_type = type
