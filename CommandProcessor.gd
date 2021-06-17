extends Node

signal changed_location(location)

onready var parent = get_parent()
func _ready() -> void:
	pass

var curr_location: Room

func initialize(starting_room) -> String:
	return change_room(starting_room)


func process_command(input: String) -> String:
	var words = input.split(" ",false)
	if words.size() == 0:
		return "No words to parse"
	var first_words = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
	match first_words:
		"ir":
			return go(second_word)
		"mirar":
			return look()
		"salir":
			exit()
			return "Exiting game"
		"investigar":
			return check()
		"ayuda":
			return help()
		_:
			return "Unrecognized command, try again"


func go(location):
	if location == "":
		return "Ir a donde?"
	
	if curr_location.exits.keys().has(location):
		var change_response = change_room(curr_location.exits[location])
		
		return PoolStringArray([
			"Te dirigiste al %s" % location,
			change_response
		]).join("\n")

	else:
		return "Salida no valida!"
 
func look():
	return "You are looking"

func check():
	pass

func help():
	return "You can use these commands: \nhelp, go [location/direction], look, check, exit"


func exit():
	yield(get_tree().create_timer(1),"timeout")
	get_tree().quit()	

func change_room(new_room: Room) -> String:
	curr_location = new_room
	var exits_strings = PoolStringArray(new_room.exits.keys()).join(" ")
	var messages = PoolStringArray([
		"Ahora estas en " + new_room.room_name +", es " + new_room.room_description,
		"Rutas: " + exits_strings
	]).join("\n")
	emit_signal("changed_location", new_room.room_name)
	return messages

#	print(new_room.room_name)
