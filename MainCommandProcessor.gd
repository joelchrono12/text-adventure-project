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
		"iniciar":
			play()
			return "Que comience el juego" 
		"salir":
			exit()
			return "Exiting game"
		"ayuda":
			return help()
		_:
			return "Comando inválido / No disponible en el menu principal"


func go(location):
	if location == "":
		return "Ir a donde?"
	
	if curr_location.exits.keys().has(location):
		var exit = curr_location.exits[location]
		if exit.is_other_room_locked(curr_location):
			return "¡No puedes pasar, esta bloqueado!"
		var change_response = change_room(exit.get_other_room(curr_location))
		
		return PoolStringArray([
			"Te dirigiste al %s" % location,
			change_response
		]).join("\n")

	else:
		return "Salida no valida!"
 
func look() -> String:
	if (curr_location.room_name) == "los creditos":
		OS.shell_open("https://github.com/joelchrono12/text-adventure-project")
	return curr_location.get_room_details()


func play() -> void:
	yield(get_tree().create_timer(1),"timeout")
	get_tree().change_scene("res://Game.tscn")

func help():
	return "Comandos disponibles:\niniciar \nayuda \nmirar \nir [dirección]  \nsalir"


func exit():
	yield(get_tree().create_timer(1),"timeout")
	get_tree().quit()	

func change_room(new_room: Room) -> String:
	curr_location = new_room
	return new_room.get_room_description() + "\n" + new_room.get_exit_description()
