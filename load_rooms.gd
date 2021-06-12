extends Node
# About your project: I would have a JSON file that contains my 
# objects with fields for ID as an int, Name as a string, 
# Description (the text for the event/room) as a string and a object 
# with string keys of options and the value is an int for the ID for 
# the room that option points to.
#
# Make a RoomLoader method that takes the int ID for a 
# room then shows the info from the object in the JSON with that ID. 
# After the room descriptions show the options and when the user picks 
# one call your RoomLoader again using the new ID.

var path = "res://data/rooms.json"
var data = {}

class Room_layout:
	var id = 0
	 
	

func _ready() -> void:
	pass

func load_rooms():
	var file = File.new()
	if not file.file_exists(path):
		reset_data()
		return
	file.open(path,file.READ)
	var text = file.get_as_text()
	#print(text)
	data = parse_json(text)
	file.close()
	return data
#	print(data)
#	for i in data["rooms"].size():
#		print(data["rooms"][str(i)]["description"])
		

func reset_data():
	pass
