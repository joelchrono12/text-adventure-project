extends Node

signal response_generated(response_text)

onready var parent = get_parent()
func _ready() -> void:
	pass

var curr_location = null

func initialize(starting_room):
	curr_location = starting_room
	print(starting_room)
	change_room(starting_room)


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
		return "Go where?"

	return "You are going to: %s" % location


func look():
	return "You are looking"

func check():
	pass

func help():
	return "You can use these commands: \nhelp, go [location/direction], look, check, exit"


func exit():
	yield(get_tree().create_timer(1),"timeout")
	get_tree().quit()	

func change_room(new_room: Room):
	curr_location = new_room
	emit_signal("response_generated", "You go to " + new_room.room_name)
	emit_signal("response_generated", new_room.room_description)
	print(new_room.room_name)
