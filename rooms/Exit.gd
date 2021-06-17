extends Resource
class_name Exit

var room_1 = null
var is_r1_locked := false

var room_2 = null
var is_r2_locked := false

func get_other_room(current_room):
	if current_room == room_1:
		return room_2
	elif current_room == room_2:
		return room_1
	else:
		printerr("Esta locación no existe")
		return null

func is_other_room_locked(current_room) -> bool:
	if current_room == room_1:
		return is_r2_locked
	elif current_room == room_2:
		return is_r1_locked
	else:
		printerr("The room is not connected to this exit")
		return true
