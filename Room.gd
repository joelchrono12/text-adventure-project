tool
extends PanelContainer
class_name Room
export (String) var room_name = "Room Name" setget set_room_name
export (String,MULTILINE) var room_description = "Room Description" setget set_room_desc

func _ready() -> void:
	pass # Replace with function body.

var exits: Dictionary = {}

func set_room_name(new_name: String):
	if Engine.editor_hint:
		$MarginContainer/Rows/RoomName.bbcode_text = new_name
	room_name = new_name


func set_room_desc(new_desc: String):
	if Engine.editor_hint:
		$MarginContainer/Rows/RoomDescription.bbcode_text = new_desc
	room_description = new_desc

func connect_exits(direction: String, room):
	match direction:
		"oeste":
			exits[direction] = room
			room.exits["este"] = self
		"este":
			exits[direction] = room
			room.exits["oeste"] = self
		"norte":
			exits[direction] = room
			room.exits["sur"] = self
		"sur":
			exits[direction] = room
			room.exits["norte"] = self
		_:
			printerr("Dirección invalida: %s", direction)
	pass
