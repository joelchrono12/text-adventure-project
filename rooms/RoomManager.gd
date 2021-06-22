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
	knife.use_value = $Bodega
	key.use_value = $Garaje
	screwdriver.use_value = $SecretRoom
	note.use_value = $HabitacionGrande
	
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
	$HabitacionGrande.connect_exit_locked("este",$Bodega)
	
	$Comedor.connect_exit_unlocked("norte",$Cocina)
	$Comedor.connect_exit_unlocked("sur",$Invernadero)
	$Invernadero.connect_exit_unlocked("este",$Garaje)
	$Bathroom.add_item(key)
	$Habitacion.add_item(note)
	$Garaje.add_item(screwdriver)
	$Cocina.add_item(knife)
