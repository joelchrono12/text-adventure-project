extends Control


const Response = preload("res://OutputResponse.tscn")
const InputResponse = preload("res://InputResponse.tscn")

# Amount of lines to store on history 
export (int) var max_scrollback := 30

onready var location_label = $PanelBackground/MarginContainer/Rows/GUI/GUI/Location
onready var history_rows = $PanelBackground/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows
onready var scroll = $PanelBackground/MarginContainer/Rows/GameInfo/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()
onready var command_proc = $CommandProcessor
onready var room_man = $RoomManager


var rooms = LoadRooms.load_rooms()
var directions = ["n","w","e","s"]
var room_list = ["lab","corridor","room","Vault"]

# I dont know what is wrong with this code 

var room_descriptions = {
	lab = "You are in some kind of laboratory facility, some red lights are flashing, your head hurts. There is a medicine in the floor, a door leads to a corridor",
	corridor = "There is a big door in front of you at the end of the corridor, a few rats are running away from you, hiding into a trash can",
	room = "There is an old bed, an aluminum plate and some fragile medical equipment"
}

var curr_location = null
var max_scroll_lenght := 0

func _ready() -> void:
	location_label.text = "Locación: ???"
	max_scroll_lenght = scrollbar.max_value
	scrollbar.connect("changed",self,"handle_scrollbar_change")
	command_proc.connect("response_generated",self,"handle_response_generated")
#	var starting_message = Response.instance()
#	starting_message.bbcode_text = "Universidad de Guadalajara \nMatematicas Discretas \n\nTitulo de Juego \n\nplay - Iniciar juego \nayuda - ver explicación de comandos y mas \n"
#	add_response_to_game(starting_message)
	
	
	
	command_proc.initialize(room_man.get_child(0))


func update_location(location):
	curr_location = location
	location_label.text = "Location: " + location


func get_description() -> String:
	var description = room_descriptions.get(curr_location)
	return description


func handle_response_generated(response_text):
	var response = Response.instance()
	response.bbcode_text = response_text
	history_rows.add_child(response)
	response.animate_text()
	print("Signal received")

	add_response_to_game(response_text)


func _on_Input_text_entered(new_text: String) -> void:
	if new_text.strip_edges(true,true) == "":
		return
	var input_response = InputResponse.instance()
	var response = command_proc.process_command(new_text)
	add_response_to_game(input_response)
	input_response.set_text(new_text, response)




func add_response_to_game(response: Control):
	history_rows.add_child(response)
	# Call function to limit the scrollback history size
	limit_scrollback()
	


func limit_scrollback():
	if history_rows.get_child_count() > max_scrollback:
		# We are deleting the first children of the history rows, 
		# which were the first ones we added. 
		var rows_to_forget = history_rows.get_child_count() - max_scrollback
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
			pass

func handle_scrollbar_change():
	if max_scroll_lenght != scrollbar.max_value:
		max_scroll_lenght = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_lenght
	pass


#func get_response(input: String) -> String:
#	var response = ""
#	var commands = ["look","go","check"]
#	input = input.to_lower()
#	if input == "look":
#		update_location(curr_location)
#		response = get_description()
#	elif "go" in input:
#		if curr_location.to_lower() in input:
#			response = "You already are in " + curr_location
#		else:
#			for room in room_list:
#				if room.to_lower() in input:
#					update_location(room)
#					response = "You have entered to " + curr_location
#					break
#				else:
#					response = "You need to input a valid location"
#	elif input == "check":
#		response = "checking"
#	elif input.to_lower() == "clear":
#		for children in history_rows.get_children():
#			children.queue_free()
#		response = "History deleted"
#	elif input.to_lower() == "exit":
#		response = "Finishing process..."
#
#	else:
#		response = "You did nothing"
#	return response
