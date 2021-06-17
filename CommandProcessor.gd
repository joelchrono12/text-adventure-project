extends Node

#signal changed_location(location)

onready var parent = get_parent()
func _ready() -> void:
	pass

var curr_location: Room = null
var player = null




func initialize(starting_room,player) -> String:
	self.player = player
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
		"tomar":
			return take(second_word)
		"soltar":
			return drop(second_word)
		"mochila":
			return inventory()
		"ayuda":
			return help()
		_:
			return "Unrecognized command, try again"


func go(location):
	if location == "":
		return "Ir a donde?"
	
	if curr_location.exits.keys().has(location):
		var exit = curr_location.exits[location]
		var change_response = change_room(exit.get_other_room(curr_location))
		
		return PoolStringArray([
			"Te dirigiste al %s" % location,
			change_response
		]).join("\n")

	else:
		return "Salida no valida!"
 
func look() -> String:
	return curr_location.get_room_description()

func take(second_word: String) -> String:
	if curr_location.items.empty():
		return "No hay nada para tomar"
	elif second_word == "":
		return "No decidiste que tomar"
		
	for item in curr_location.items:
		if second_word.to_lower() == item.item_name: 
			curr_location.remove_item(item) 
			player.take_item(item)
			return "Tomaste un(a) " + item.item_name
	return "No hay ningun objeto asi"
	
func drop(second_word: String) -> String:
	if player.inventory.empty():
		return "No hay nada para soltar"
	elif second_word == "":
		return "No decidiste que soltar"
		
	for item in player.inventory:
		if second_word.to_lower() == item.item_name: 
			curr_location.add_item(item) 
			player.drop_item(item)
			return "Soltaste un(a) " + item.item_name
	return "No tienes ningun objeto asi"

func inventory() -> String:
	return player.get_inventory_list()

func help():
	return "Comandos disponibles: \nayuda, \nir [dirección], \nmirar, \ntomar [objeto], \nsoltar [objeto] \nsalir"


func exit():
	yield(get_tree().create_timer(1),"timeout")
	get_tree().quit()	

func change_room(new_room: Room) -> String:
	curr_location = new_room
	return new_room.get_full_description()
