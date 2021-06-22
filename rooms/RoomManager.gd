extends Node


func _ready():
	var key = Item.new()
	var knife = Item.new()
	var screwdriver = Item.new()
	var crank = Item.new()
	var note = Item.new()
	key.initialize("llave", Types.ItemTypes.KEY)
	knife.initialize("cuchillo", Types.ItemTypes.KEY)
	note.initialize("nota",Types.ItemTypes.KEY)
	screwdriver.initialize("desarmador",Types.ItemTypes.KEY)
	knife.use_value = $BigBath
	key.use_value = $Bodega
	screwdriver.use_value = $Garaje
	note.use_value = $ParkingLot
	
	# Conectamos todos los cuartos de la sala principal	
	$Sala.connect_exit_unlocked("norte", $Pasillo)
	$Sala.connect_exit_locked("sur", $ParkingLot)
	$Sala.connect_exit_unlocked("este", $Comedor)
	$Sala.connect_exit_unlocked("oeste",$Bathroom)
	
	# Conectamos el pasillo con habitaciones
	$Pasillo.connect_exit_unlocked("oeste",$Habitacion)
	$Pasillo.connect_exit_locked("norte",$HabitacionGrande)
	
	# Conectar habitacion pequeña con el baño
	$Habitacion.connect_exit_unlocked("sur",$Bathroom)
	
	# Conectar habitacion grande con baño
	$HabitacionGrande.connect_exit_unlocked("oeste",$BigBath)
	
	$Comedor.connect_exit_unlocked("norte",$Cocina)
	$Comedor.connect_exit_unlocked("sur",$Invernadero)
	$Invernadero.connect_exit_unlocked("este",$Garaje)
	$Bathroom.add_item(key)
	$Habitacion.add_item(note)
	$Cocina.add_item(screwdriver)
