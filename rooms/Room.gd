tool
extends PanelContainer

class_name Room

export (String) var room_name = "Room Name" setget set_room_name
export (String,MULTILINE) var room_description = "Room Description" setget set_room_desc
export (String,MULTILINE) var room_details = "Room Details"

var exits: Dictionary = {}
var items: Array = []


func connect_exit_unlocked(direction: String, room):
	_connect_exits(direction, room, false, false)

func connect_exit_locked(direction: String, room):
	_connect_exits(direction, room, true, false)

func _connect_exits(direction: String, room, is_locked: bool, is_hidden: bool):
	var exit = Exit.new()

	exit.room_1 = self
	exit.room_2 = room
	exit.is_hidden = is_hidden
	exit.is_r2_locked = is_locked
	exits[direction] = exit
	match direction:
		"oeste":
			room.exits["este"] = exit
		"este":
			room.exits["oeste"] = exit  
		"norte":
			room.exits["sur"] = exit
		"sur":
			room.exits["norte"] = exit
		_:
			printerr("Dirección invalida: %s", direction)
func set_room_name(new_name: String):
	if Engine.editor_hint:
		$MarginContainer/Rows/RoomName.bbcode_text = new_name
	room_name = new_name


func add_item(item: Item):
	items.append(item)
	
func remove_item(item: Item):
	items.erase(item)
	

func get_full_description() -> String:
	var full_description = PoolStringArray([
		get_room_description(),
#		get_item_description(),
		get_exit_description()
	]).join("\n") 
	return full_description

func get_room_description() -> String:
	return "Estas en " + room_name +", es " + room_description

func get_item_description() -> String:
	if items.size() == 0:
		print("No hay objetoss")
		return "No parece haber objetos aqui"
		
	var item_string = ""
	for item in items:
		item_string += item.item_name + " "

	return "Objetos: " + item_string

func get_exit_description() -> String:
	return "Rutas: " + PoolStringArray(exits.keys()).join(" / ")
	
func get_room_details() -> String:
	if room_details.empty():
		return "No hay nada mas que ver"
	else:
		var full_details = PoolStringArray([
			room_details,
			get_item_description(),
		]).join("\n") 
		return full_details
	

func set_room_desc(new_desc: String):
	if Engine.editor_hint:
		$MarginContainer/Rows/RoomDescription.bbcode_text = new_desc
	room_description = new_desc
