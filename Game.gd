extends Control


const Response = preload("res://input/OutputResponse.tscn")
const InputResponse = preload("res://input/InputResponse.tscn")

# Amount of lines to store on history 
export (int) var max_scrollback := 30

onready var location_label = $PanelBackground/MarginContainer/Rows/GUI/GUI/Location
onready var history_rows = $PanelBackground/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows
onready var scroll = $PanelBackground/MarginContainer/Rows/GameInfo/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()
onready var command_proc = $CommandProcessor
onready var room_man = $RoomManager
onready var player = $Player

var rooms = LoadRooms.load_rooms()


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
	create_response("Universidad de Guadalajara \nMatematicas Discretas \nEscribe 'ayuda' para ver mas comandos \n-------------")
	var start_room_response = command_proc.initialize(room_man.get_child(0),player)
	create_response(start_room_response)


func update_location(location):
	location_label.text = "Locación: " + location
	print("changed locations")


func create_response(response_text: String):
	var response = Response.instance()
	response.bbcode_text = response_text
	history_rows.add_child(response)
	add_response_to_game(response)
#	response.animate_text()


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
